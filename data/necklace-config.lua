--[[
    CONFIGURAÇÃO DE TRANSFORMAÇÃO DE COLARES
    ========================================
    
    Este arquivo define as transformações que ocorrem nos colares quando um jogador morre.
    
    COMO FUNCIONA:
    - Quando um jogador morre, o sistema verifica se ele está usando um colar
    - Se o colar estiver na lista de transformações, ele será substituído pelo item correspondente
    - Se o colar não estiver na lista, nada acontece
    
    FORMATO DA CONFIGURAÇÃO:
    [ID_DO_COLAR_ORIGINAL] = ID_DO_ITEM_RESULTANTE
    
    EXEMPLO:
    [38906] = 2197  -- Colar energizado (ID 38906) vira item desenergizado (ID 2197)
    
    COMO ADICIONAR NOVOS COLARES:
    1. Encontre o ID do colar energizado
    2. Encontre o ID do item que deve aparecer após a morte
    3. Adicione uma nova linha seguindo o formato: [ID_ENERGIZADO] = ID_DESENERGIZADO,
    4. Não esqueça da vírgula no final (exceto na última linha)
    
    OBSERVAÇÕES:
    - Os IDs devem ser números válidos de itens existentes no servidor
    - Se você colocar 0 como valor, o colar simplesmente desaparecerá
    - Certifique-se de que os IDs estão corretos para evitar erros
--]]

necklaceTransformations = {
    -- Colares energizados que se transformam em desenergizados após a morte
    [38906] = 2197,     -- Colar energizado -> Item desenergizado
    [38901] = 38902,    -- Colar energizado -> Colar desenergizado
    [38900] = 38894,    -- Colar energizado -> Colar desenergizado
    
    -- ADICIONE NOVOS COLARES AQUI:
    -- [ID_COLAR_ENERGIZADO] = ID_ITEM_DESENERGIZADO,
    -- Exemplo: [12345] = 12346,
}

--[[
    FUNÇÃO DE TRANSFORMAÇÃO
    =======================
    
    Esta função é chamada automaticamente pelo sistema quando um jogador morre.
    Ela recebe o ID do colar e retorna o ID do item que deve substituí-lo.
    
    PARÂMETROS:
    - necklaceId: ID do colar que o jogador estava usando
    
    RETORNO:
    - ID do item que deve substituir o colar, ou 0 se não houver transformação
--]]
function getNecklaceTransformation(necklaceId)
    return necklaceTransformations[necklaceId] or 0
end