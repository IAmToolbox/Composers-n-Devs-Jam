@abstract class_name Enemy extends Node
## Abstract class for enemies to inherit from

## This function is called when the enemy needs to move towards the player
@abstract func move_towards_player()

## This function is called when the enemy needs to move towards an arbitrary target
@abstract func move_towards_target()

## This function is called when the enemy fires a projectile
@abstract func fire_projectile()
