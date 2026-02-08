/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2014  Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include "otpch.h"

#include "protocolgame.h"
#include "protocolspectator.h"

#include "outputmessage.h"

#include "tile.h"
#include "player.h"
#include "chat.h"

#include "configmanager.h"

#include "game.h"

#include "connection.h"
#include "scheduler.h"
#include "ban.h"

extern Game g_game;
extern ConfigManager g_config;
extern Chat* g_chat;

ProtocolSpectator::ProtocolSpectator(Connection_ptr connection):
	ProtocolGameBase(connection),
	client(nullptr)
{

}

void ProtocolSpectator::disconnectSpectator(const std::string& message) const
{
	auto output = OutputMessagePool::getOutputMessage();
	output->addByte(0x14);
	output->addString(message);
	send(std::move(output));
	disconnect();
}

void ProtocolSpectator::onRecvFirstMessage(NetworkMessage& msg)
{
	if (g_game.getGameState() == GAME_STATE_SHUTDOWN) {
		disconnect();
		return;
	}

	operatingSystem = (OperatingSystem_t)msg.get<uint16_t>();
	version = msg.get<uint16_t>();
	if (version >= 1111) {
		setChecksumMethod(CHECKSUM_METHOD_SEQUENCE);
	} else if (version >= 830) {
		setChecksumMethod(CHECKSUM_METHOD_ADLER32);
	}

	msg.skipBytes(7); // U32 clientVersion, U8 clientType

	if (!RSA_decrypt(msg)) {
		disconnect();
		return;
	}

	uint32_t key[4];
	key[0] = msg.get<uint32_t>();
	key[1] = msg.get<uint32_t>();
	key[2] = msg.get<uint32_t>();
	key[3] = msg.get<uint32_t>();
	enableXTEAEncryption();
	setXTEAKey(key);

	msg.skipBytes(1); // gamemaster flag

	std::string sessionKey = msg.getString();
	size_t pos = sessionKey.find('\n');
	if (pos == std::string::npos) {
		disconnectSpectator("You must enter your account name.");
		return;
	}

	std::string accountName = sessionKey.substr(0, pos);
	if (accountName.empty()) {

	}
	std::string password = sessionKey.substr(pos + 1);
	if (password.empty()) {
		password = ""; // Allow empty password for cast
	}
	std::string characterName = msg.getString();

	uint32_t timeStamp = msg.get<uint32_t>();
	uint8_t randNumber = msg.getByte();
	if (challengeTimestamp != timeStamp || challengeRandom != randNumber) {
		disconnect();
		return;
	}

	if (version < g_config.getNumber(ConfigManager::VERSION_MIN) || version > g_config.getNumber(ConfigManager::VERSION_MAX)) {
		std::ostringstream ss;
		ss << "Only clients with protocol " << g_config.getString(ConfigManager::VERSION_STR) << " allowed!";
		disconnectSpectator(ss.str());
		return;
	}

	if (g_game.getGameState() == GAME_STATE_STARTUP) {
		disconnectSpectator("Gameworld is starting up. Please wait.");
		return;
	}

	if (g_game.getGameState() == GAME_STATE_MAINTAIN) {
		disconnectSpectator("Gameworld is under maintenance. Please re-connect in a while.");
		return;
	}

	BanInfo banInfo;
	if (IOBan::isIpBanned(getIP(), banInfo)) {
		if (banInfo.reason.empty()) {
			banInfo.reason = "(none)";
		}

		std::ostringstream ss;
		ss << "Your IP has been banned until " << formatDateShort(banInfo.expiresAt) << " by " << banInfo.bannedBy << ".\n\nReason specified:\n" << banInfo.reason;
		disconnectSpectator(ss.str());
		return;
	}
//	password.erase(password.begin()); //Erase whitespace from the front of the password string
	std::string realName = characterName;
	std::size_t lvPos = characterName.find(" (Lv ");
	if (lvPos != std::string::npos) {
		realName = characterName.substr(0, lvPos);
	}

	g_dispatcher.addTask(createTask(std::bind(&ProtocolSpectator::login, std::static_pointer_cast<ProtocolSpectator>(shared_from_this()), realName, password)));
}

void ProtocolSpectator::sendEmptyTileOnPlayerPos(const Tile* tile, const Position& playerPos)
{
	NetworkMessage msg;

	msg.addByte(0x69);
	msg.addPosition(playerPos);

	if (tile) {
		GetTileDescription(tile, msg);
		msg.addByte(0x00);
		msg.addByte(0xFF);
	} else {
		msg.addByte(0x01);
		msg.addByte(0xFF);
	}
	writeToOutputBuffer(msg);
}

void ProtocolSpectator::addDummyCreature(NetworkMessage& msg, const uint32_t& creatureID, const Position& playerPos)
{
	// add dummy creature
	CreatureType_t creatureType = CREATURETYPE_NPC;
	if(creatureID <= 0x10000000) {
		creatureType = CREATURETYPE_PLAYER;
	} else if(creatureID <= 0x40000000) {
		creatureType = CREATURETYPE_MONSTER;
	}
	msg.addByte(0x6A);
	msg.addPosition(playerPos);
	msg.addByte(1); //stackpos
	msg.add<uint16_t>(0x61); // is not known
	msg.add<uint32_t>(0); // remove no creature
	msg.add<uint32_t>(creatureID); // creature id
	msg.addByte(creatureType); // creature type
	msg.addString("Dummy");
	msg.addByte(0x00); // health percent
	msg.addByte(DIRECTION_NORTH); // direction
	AddOutfit(msg, player->getCurrentOutfit()); // outfit
	msg.addByte(0); // light level
	msg.addByte(0); // light color
	msg.add<uint16_t>(200); // speed
	msg.addByte(SKULL_NONE); // skull type
	msg.addByte(SHIELD_NONE); // party shield
	msg.addByte(GUILDEMBLEM_NONE); // guild emblem
	msg.addByte(creatureType); // creature type
	if(version >= 1215 && creatureType == CREATURETYPE_PLAYER) {
		msg.addByte(0x01); // unknow
		msg.addByte(0x00); // unknow
	}
	if(version < 1215 || creatureType != CREATURETYPE_PLAYER) {
		msg.addByte(SPEECHBUBBLE_NONE); // speechbubble
	}
	msg.addByte(0xFF); // MARK_UNMARKED
	if (version >= 1110) {
		msg.addByte(((version < 1220 || creatureType == CREATURETYPE_MONSTER) ? 0x00 : 0x05)); // inspection type
	}
	if (version < 1185) {
		msg.add<uint16_t>(0x00);
	}
	msg.addByte(0); // walkThrough
}

void ProtocolSpectator::syncKnownCreatureSets()
{
	const auto& casterKnownCreatures = client->getKnownCreatures();
	const auto playerPos = player->getPosition();
	const auto tile = player->getTile();

	if (!tile || !tile->getGround()) {
		disconnectSpectator("A sync error has occured.");
		return;
	}
	sendEmptyTileOnPlayerPos(tile, playerPos);

	bool known;
	uint32_t removedKnown;
	for (const auto creatureID : casterKnownCreatures) {
		if (knownCreatureSet.find(creatureID) != knownCreatureSet.end()) {
			continue;
		}

		NetworkMessage msg;
		const auto creature = g_game.getCreatureByID(creatureID);
		if (creature && !creature->isRemoved()) {
			msg.addByte(0x6A);
			msg.addPosition(playerPos);
			msg.addByte(1); //stackpos
			checkCreatureAsKnown(creature->getID(), known, removedKnown);
			AddCreature(msg, creature, known, removedKnown);
			RemoveTileThing(msg, playerPos, 1);
		} else if (operatingSystem <= CLIENTOS_FLASH) { // otclient freeze with huge amount of creature add, but do not debug if there are unknown creatures, best solution for now :(
			addDummyCreature(msg, creatureID, playerPos);
			RemoveTileThing(msg, playerPos, 1);
		}
		writeToOutputBuffer(msg);
	}

	sendUpdateTile(tile, playerPos);
}

void ProtocolSpectator::syncChatChannels()
{
	const auto channels = g_chat->getChannelList(*player);
	for (const auto channel : channels) {
		const auto& channelUsers = channel->getUsers();
		if (channelUsers.find(player->getID()) != channelUsers.end()) {
			sendChannel(channel->getId(), channel->getName(), &channelUsers, channel->getInvitedUsers());
		}
	}
	sendChannel(CHANNEL_CAST, LIVE_CAST_CHAT_NAME, nullptr, nullptr);
}

void ProtocolSpectator::syncOpenContainers()
{
	const auto& openContainers = player->getOpenContainers();
	for (const auto& it : openContainers) {
		auto openContainer = it.second;
		auto container = openContainer.container;
		sendContainer(it.first, container, container->hasParent(), openContainer.index);
	}
}

void ProtocolSpectator::login(const std::string& liveCastName, const std::string& password)
{
	//dispatcher thread
	auto _player = g_game.getPlayerByName(liveCastName);
	if (!_player || _player->isRemoved()) {
		disconnectSpectator("Live cast no longer exists. Please relogin to refresh the list.");
		return;
	}

	if (_player->getProtocolVersion() != version) {
		std::ostringstream ss;
		ss << "This cast is for client version " << static_cast<double>(_player->getProtocolVersion()/100) << " only";
		disconnectSpectator(ss.str());
		return;
	}

	const auto liveCasterProtocol = ProtocolGame::getLiveCast(_player);
	if (!liveCasterProtocol) {
		disconnectSpectator("Live cast no longer exists. Please relogin to refresh the list.");
		return;
	}

	if(liveCasterProtocol->getSpectatorCount() >= 20) {
		disconnectSpectator("Live cast full. Please relogin to refresh the list.");
		return;
	}

	const auto& liveCastPassword = liveCasterProtocol->getLiveCastPassword();
	
	if (liveCasterProtocol->isLiveCaster()) {
		if (!liveCastPassword.empty() && password != liveCastPassword) {
			disconnectSpectator("Wrong live cast password.");
			return;
		}

		player = _player;
		player->incrementReferenceCounter();
		eventConnect = 0;
		client = liveCasterProtocol;
		acceptPackets = true;
		liveCasterProtocol->incrementeLiveCastViews();
		viewerName = viewerName + " " + std::to_string(liveCasterProtocol->getLiveCastViews());
		OutputMessagePool::getInstance().addProtocolToAutosend(shared_from_this());
		sendAddCreature(player, player->getPosition(), 0, false);
		syncKnownCreatureSets();
		syncChatChannels();
		syncOpenContainers();
		liveCasterProtocol->addSpectator(std::static_pointer_cast<ProtocolSpectator>(shared_from_this()));
		sendWelcomeMessage();
	} else {
		disconnectSpectator("Live cast no longer exists. Please relogin to refresh the list.");
	}
}

void ProtocolSpectator::logout()
{
	acceptPackets = false;
	if (client && player) {
		client->removeSpectator(std::static_pointer_cast<ProtocolSpectator>(shared_from_this()));
		player->decrementReferenceCounter();
		player = nullptr;
	}
	disconnect();
}

void ProtocolSpectator::parsePacket(NetworkMessage& msg)
{
	if (!acceptPackets || g_game.getGameState() == GAME_STATE_SHUTDOWN || msg.getLength() <= 0) {
		return;
	}

	uint8_t recvbyte = msg.getByte();

	if (!player) {
		if (recvbyte == 0x0F) {
			disconnect();
		}

		return;
	}

	//a dead player can not perform actions
	if (player->isRemoved() || player->getHealth() <= 0) {
		disconnect();
		return;
	}

	switch (recvbyte) {
		case 0x14: g_dispatcher.addTask(createTask(std::bind(&ProtocolSpectator::logout, getThis()))); break;
		case 0x1D: g_dispatcher.addTask(createTask(std::bind(&ProtocolSpectator::sendPingBack, getThis()))); break;
		case 0x1E: g_dispatcher.addTask(createTask(std::bind(&ProtocolSpectator::sendPing, getThis()))); break;
		//Reset viewed position/direction if the spectator tries to move in any way
		case 0x64: case 0x65: case 0x66: case 0x67: case 0x68: case 0x6A: case 0x6B: case 0x6C: case 0x6D: case 0x6F: case 0x71:
		case 0x70: // Turn East - used for Next Cast (CTRL + RIGHT)
			g_dispatcher.addTask(createTask(std::bind(&ProtocolSpectator::parseSwitchCast, getThis(), uint8_t(1))));
			break;
		case 0x72: // Turn West - used for Prev Cast (CTRL + LEFT)
			g_dispatcher.addTask(createTask(std::bind(&ProtocolSpectator::parseSwitchCast, getThis(), uint8_t(0))));
			break;
		case 0x8C: g_dispatcher.addTask(createTask(std::bind(&ProtocolSpectator::parseLookAt, getThis(), msg))); break;
		case 0x96: parseSpectatorSay(msg); break;
		default:
			break;
	}

	if (msg.isOverrun()) {
		disconnect();
	}
}

void ProtocolSpectator::parseSpectatorSay(NetworkMessage& msg)
{
	SpeakClasses type = (SpeakClasses)msg.getByte();
	uint16_t channelId = 0;

	if (type == TALKTYPE_CHANNEL_Y) {
		channelId = msg.get<uint16_t>();
	} else {
		return;
	}

	const std::string text = msg.getString();

	if (text.length() > 255 || channelId != CHANNEL_CAST || !client) {
		return;
	}

	if (client) {
		g_dispatcher.addTask(createTask(std::bind(&ProtocolGame::sendSpectatorMessage, client, viewerName, text)));
		// g_dispatcher.addTask(createTask(std::bind(&ProtocolGame::broadcastSpectatorMessage, client, text)));
	}
}

void ProtocolSpectator::release()
{
	//dispatcher
	if (client && player) {
		client->removeSpectator(std::static_pointer_cast<ProtocolSpectator>(shared_from_this()));
		player->decrementReferenceCounter();
		player = nullptr;
	}
	Protocol::release();
	OutputMessagePool::getInstance().removeProtocolFromAutosend(shared_from_this());
}

void ProtocolSpectator::writeToOutputBuffer(const NetworkMessage& msg, bool broadcast)
{
	(void)broadcast; // Marca o par�metro como usado
	OutputMessage_ptr out = getOutputBuffer(msg.getLength());
	out->append(msg);
}

void ProtocolSpectator::onLiveCastStop()
{
	//dispatcher
	if (player) {
		player->decrementReferenceCounter();
		player = nullptr;
	}
	disconnect();
}

void ProtocolSpectator::sendFloorDescription(const Position& pos, int floor)
{
	// Spectators use the same implementation as ProtocolGame
	NetworkMessage msg;
	msg.addByte(0x4B);
	msg.addPosition(player->getPosition());
	msg.addByte(static_cast<uint8_t>(floor));
	int32_t skip = -1;
	GetFloorDescription(msg, pos.x - awareRange.left(), pos.y - awareRange.top(), floor, awareRange.horizontal(), awareRange.vertical(), pos.z - floor, skip);
	if (skip >= 0) {
		msg.addByte(static_cast<uint8_t>(skip));
		msg.addByte(0xFF);
	}
	writeToOutputBuffer(msg);
}

void ProtocolSpectator::parseLookAt(NetworkMessage& msg)
{
	Position pos = msg.getPosition();
	msg.skipBytes(2);
	uint8_t stackpos = msg.getByte();

	if (!player) {
		return;
	}

	if (pos.x != 0xFFFF && !player->canSee(pos)) {
		return;
	}

	// We use the caster's ID to perform the look action, effectively letting the caster "look" at the position.
	// This might need adjustment if the intention is for the spectator to receive the info directly without the caster knowing.
	g_game.playerLookAt(player->getID(), pos, stackpos);
}

void ProtocolSpectator::parseSwitchCast(uint8_t direction)
{
	if (!player || !client) {
		return;
	}

	const auto& liveCasts = ProtocolGame::getLiveCasts();
	if (liveCasts.empty()) {
		sendTextMessage(MESSAGE_STATUS_SMALL, "No live casts available.");
		return;
	}

	std::vector<Player*> casters;
	for (const auto& entry : liveCasts) {
		casters.push_back(entry.first);
	}

	auto it = std::find(casters.begin(), casters.end(), player);
	if (it == casters.end()) {
		// Current caster not found in list, fallback to first
		if (!casters.empty()) {
			Player* newCaster = casters[0];
			ProtocolGame_ptr newClient = ProtocolGame::getLiveCast(newCaster);
			if (newCaster && newClient && newCaster != player) {
				client->removeSpectator(getThis());
				client->sendChannelMessage("", viewerName + " has left the cast.", TALKTYPE_CHANNEL_O, CHANNEL_CAST);

				knownCreatureSet.clear();
				player = newCaster;
				client = newClient;
				client->addSpectator(getThis());
				
				// Update viewerName count if needed, but keeping it simple for now
				
				sendAddCreature(player, player->getPosition(), 0, false);
				syncKnownCreatureSets(); // Sync known creatures
				syncOpenContainers();
				client->sendChannelMessage("", viewerName + " has joined the cast.", TALKTYPE_CHANNEL_O, CHANNEL_CAST);
				sendMagicEffect(player->getPosition(), CONST_ME_TELEPORT);
			}
		}
		return;
	}

	size_t currentIndex = std::distance(casters.begin(), it);
	size_t newIndex;

	if (direction == 1) {
		newIndex = (currentIndex + 1) % casters.size();
	} else {
		newIndex = (currentIndex == 0) ? casters.size() - 1 : currentIndex - 1;
	}

	if (newIndex == currentIndex) {
		sendTextMessage(MESSAGE_STATUS_SMALL, "No other casts available.");
		return;
	}

	Player* newCaster = casters[newIndex];
	ProtocolGame_ptr newClient = ProtocolGame::getLiveCast(newCaster);
	
	if (!newCaster || newCaster == player || !newClient) {
		return;
	}

	client->removeSpectator(getThis());
	client->sendChannelMessage("", viewerName + " has left the cast.", TALKTYPE_CHANNEL_O, CHANNEL_CAST);

	knownCreatureSet.clear();
	player = newCaster;
	client = newClient;
	client->addSpectator(getThis());
	
	sendAddCreature(player, player->getPosition(), 0, false);
	syncKnownCreatureSets(); // Sync known creatures
	syncOpenContainers();
	client->sendChannelMessage("", viewerName + " has joined the cast.", TALKTYPE_CHANNEL_O, CHANNEL_CAST);
	sendMagicEffect(player->getPosition(), CONST_ME_TELEPORT);

	std::stringstream ss;
	ss << "Switched to cast: " << player->getName();
	sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, ss.str());
}

void ProtocolSpectator::sendWelcomeMessage()
{
	std::string message = 
		"Welcome to the Live Cast System!\n\n"
		"Do you know you can use CTRL + ARROWS to switch casts?\n\n"
		"Voce sabia que pode usar CTRL + SETAS para alternar casts?\n\n"
		"Type /commands in the cast channel to see available commands.";
	
	sendTextMessage(MESSAGE_EVENT_ADVANCE, message);
}

void ProtocolSpectator::sendTextMessage(MessageClasses mclass, const std::string& message)
{
	NetworkMessage msg;
	msg.addByte(0xB4);
	msg.addByte(mclass);
	msg.addString(message);
	writeToOutputBuffer(msg);
}

