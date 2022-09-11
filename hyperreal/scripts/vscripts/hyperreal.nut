MutationOptions <-
{

}

// SessionOptions exists for influencing the Director on the fly.

MutationState <-
{

}

//function AllowBash (basher, bashed)
//{
//
//}

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
        damageTable.rawget("DamageDone") *= 10;
        break;

      // bullet wounds (including shotguns)
      case DMG_BULLET:
      case DMG_BUCKSHOT:
        switch (damage_weapon_class)
        {
          case "weapon_sniper_awp":
            damageTable.rawget("DamageDone") *= 4.8;
            break;

          case "weapon_sniper_scout":
            damageTable.rawget("DamageDone") *= 4.8;
            break;

          default:
            damageTable.rawget("DamageDone") *= 2.4;
            break;
        }
        break;

      // rebalancing melee weapons
      case DMG_MELEE:
        switch (damage_weapon_class)
        {
          DumpObject(damage_weapon);
          // case slash:
          // case blunt:
          // default:
          //  break;
        }
        break;

      default:
        break;
    }
  }

  // DumpObject(damage_weapon);
  // ClientPrint(null, HUD_PRINTNOTIFY, damage_weapon.GetClassname());
  return true;
}

function Update ()
{

}
