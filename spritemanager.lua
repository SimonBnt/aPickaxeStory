local spriteManager = {}

spriteManager.liste_sprites = {}

spriteManager.CreerSprite = function(pNomImage, pNbImages, pX, pY)
  
  sprite = {}
  sprite.x = pX
  sprite.y = pY
  sprite.frame = 1
  sprite.vx = 0
  sprite.vy = 0
  sprite.flip = 1
  -- sprite.ox = 16
  -- sprite.oy = 31
  sprite.images = {}
  local imgNum
  for imgNum = 1,pNbImages do
    sprite.images[imgNum] = love.graphics.newImage("image_hero/"..pNomImage..imgNum..".png")
  end   
  sprite.l = sprite.images[1]:getWidth()
  sprite.h = sprite.images[1]:getHeight()
  
  table.insert(spriteManager.liste_sprites, sprite)
  
  sprite.Anime = function(dt)
    sprite.frame = sprite.frame + 10*dt
    if sprite.frame >= #sprite.images then
      sprite.frame = 1
    end
  end
  
  sprite.Deplace = function(dt)
    -- Réduction de la vélocité (=friction)
    sprite.vx = sprite.vx * .65
    sprite.vy = sprite.vy * .65
    if math.abs(sprite.vx) < 0.01 then sprite.vx = 0 end
    if math.abs(sprite.vy) < 0.01 then sprite.vy = 0 end
    
    -- Application de la vélocité
    sprite.x = sprite.x + sprite.vx
    sprite.y = sprite.y + sprite.vy
  end
  
  return sprite
  
end

spriteManager.update = function(dt)
  local n
  for n=1,#spriteManager.liste_sprites do
    local s = spriteManager.liste_sprites[n]
    s.Deplace(dt)
    s.Anime(dt)
  end
end

spriteManager.draw = function()
  local n
  for n=1,#spriteManager.liste_sprites do
    local s = spriteManager.liste_sprites[n]
    local frame = s.images[math.floor(s.frame)]
    love.graphics.draw(frame, s.x, s.y, 0, s.flip, 1, s.l/2, s.h/2)
  end
end

return spriteManager