local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_disclaimer")

MySQL.createCommand("vRP/disclaimer_init", "ALTER TABLE `vrp_users` ADD `disclaimer` int(2) DEFAULT 0;")
MySQL.createCommand("vRP/disclaimer_get", "SELECT `disclaimer` FROM `vrp_users` WHERE `id` = @user_id;")
MySQL.createCommand("vRP/disclaimer_set", "UPDATE `vrp_users` SET `disclaimer` = 1 WHERE `id` = @user_id;")

-- IMPORTANT: dupa primul start al server-ului comenteaza comanda de mai jos
MySQL.query("vRP/disclaimer_init")


AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
  if first_spawn then
    MySQL.query("vRP/disclaimer_get", {user_id = user_id}, function(rows, affected)
      if rows[1].disclaimer == 0 then
        TriggerClientEvent("disclaimer:start", source)
        MySQL.execute("vRP/disclaimer_set", {user_id = user_id})
      end
    end)
  end
end)

RegisterCommand("disclaimer", function(source, args)
  TriggerClientEvent("disclaimer:start", source)
end)
