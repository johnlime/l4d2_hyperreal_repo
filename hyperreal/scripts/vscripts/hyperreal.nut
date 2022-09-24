MutationOptions <-
{
  MobMaxSize = 100
  MegaMobSize = 500
}

// SessionOptions exists for influencing the Director on the fly.

MutationState <-
{

}

MobSpawn <- {
  type = ZSPAWN_MOB,
  pos = null,
}
// witch spawns mob
function OnGameEvent_witch_harasser_set (params) // userid; witchid; first
{
  Director.PlayMegaMobWarningSounds();
  MobSpawn.pos = EntIndexToHScript(params["witchid"]).GetOrigin();

  local i
  for (i = 0; i < 2; i++){
    ZSpawn(MobSpawn);
  }
}

function AllowBash (basher, bashed)
{
  return ALLOW_BASH_ALL;
}

function AllowTakeDamage (damageTable)
{
  local damage_type = damageTable.rawget("DamageType");
  local damage_weapon = damageTable.rawget("Weapon");
  if (damage_weapon != null)
  {
    local damage_weapon_class = damage_weapon.GetClassname();
    switch (damage_type)
    {
      // headshots should insta-kill most things
      case DMG_HEADSHOT:
        damageTable.rawset("DamageDone", damageTable.rawget("DamageDone") * 50);
        DumpObject(damageTable);
        break;

      // bullet wounds (including shotguns)
      case DMG_BULLET:
      case DMG_BUCKSHOT:
        switch (damage_weapon_class)
        {
          case "weapon_sniper_awp":
            damageTable.rawset("DamageDone", damageTable.rawget("DamageDone") * 10);
            break;

          case "weapon_sniper_scout":
            damageTable.rawset("DamageDone", damageTable.rawget("DamageDone") * 10);
            break;

          default:
            damageTable.rawset("DamageDone", damageTable.rawget("DamageDone") * 4.8);
            break;
        }
        break;

      // rebalancing melee weapons
      case 2097280: //DMG_MELEE doesn't work
        // damage_weapon_class = "weapon_melee"
        local damage_victim = damageTable.rawget("Victim");
        local damage_victim_class = null;
        if (damage_victim != null)
        {
          damage_victim_class = damage_victim.GetClassname();
          if (damage_victim_class == "infected") // alternative is "player" instead of "survivor"
          {
              // slash damage and blunt damage will just be scaled
              damageTable.rawset("DamageDone", damageTable.rawget("DamageDone") * 0.05);
          }
        }
        break;

      case DMG_BLAST:
        damageTable.rawset("DamageDone", 500);

      default:
        break;
    }
  }

  // DumpObject(damage_Table);
  // ClientPrint(null, HUD_PRINTNOTIFY, damage_weapon.GetClassname());
  return true;
}

function Update ()
{

}
