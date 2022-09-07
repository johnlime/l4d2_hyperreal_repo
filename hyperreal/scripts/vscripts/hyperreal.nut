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
  local damage_entity = damageTable.rawget("Victim")
  local damage_entity_class = damage_entity.GetClassname()
  local damage_weapon = damageTable.rawget("Weapon")
  if (damage_weapon != null)
  {
    if (damage_weapon.GetClassname() == "weapon_pistol")
    {
      
    }
  }

  // DumpObject(damage_weapon)
  // ClientPrint(null, HUD_PRINTNOTIFY, damage_weapon.GetClassname())
  // ([402] weapon_pistol) [5]
  // {
  //   _class : (class : 0x06E43CF0) [4]
  // }
  return true
}

function Update ()
{

}
