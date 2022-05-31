love.graphics.setDefaultFilter("nearest", "nearest")
--Sprite mannager--
local spriteManager = require("spritemanager")

-- Globales utiles
local largeurEcran
local hauteurEcran

-- Constantes
local largeurTuille = 32
local hauteurTuille = 32

-- Le donjon
local donjon = require("donjon")

--salle dans laquelle est le hero--
local salleCourante = {}
salleCourante.porte = {}

local piocheSprite = {}

local murs = {}

  murs[1]  = { 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 }
  murs[2]  = { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 }
  murs[3]  = { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 }
  murs[4]  = { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 }
  murs[5]  = { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 }
  murs[6]  = { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 }
  murs[7]  = { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 }
  murs[8]  = { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 }
  murs[9]  = { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 }
  murs[10] = { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 }
  murs[11] = { 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 }
  
-- la map de fond-- 
local imgMap = {}

imgMap[0] = love.graphics.newImage("32x32/herbe/herbe.png")
imgMap[1] = love.graphics.newImage("32x32/herbe/herbe_terre1.png")
imgMap[2] = love.graphics.newImage("32x32/herbe/herbe_terre2.png")
imgMap[3] = love.graphics.newImage("32x32/herbe/herbe_terre3.png")
imgMap[4] = love.graphics.newImage("32x32/herbe/herbe_terre4.png")
imgMap[5] = love.graphics.newImage("32x32/terre/terre_nue.png")
imgMap[6] = love.graphics.newImage("32x32/terre/terre1.png")
imgMap[7] = love.graphics.newImage("32x32/terre/terre2.png")
imgMap[8] = love.graphics.newImage("32x32/terre/terre3.png")
imgMap[9] = love.graphics.newImage("32x32/terre/terre4.png")
imgMap[10] = love.graphics.newImage("32x32/terre/terre_angle1.png")
imgMap[11] = love.graphics.newImage("32x32/terre/terre_angle2.png")
imgMap[12] = love.graphics.newImage("32x32/terre/terre_angle3.png")
imgMap[13] = love.graphics.newImage("32x32/terre/terre_angle4.png")
imgMap[14] = love.graphics.newImage("32x32/eau/eau.png")
imgMap[15] = love.graphics.newImage("32x32/mur/mur1.png")
imgMap[16] = love.graphics.newImage("32x32/mur/mur2.png")
imgMap[17] = love.graphics.newImage("32x32/mur/mur3.png")
imgMap[18] = love.graphics.newImage("32x32/mur/mur4.png")
imgMap[19] = love.graphics.newImage("32x32/mur/mur_angle1.png")
imgMap[20] = love.graphics.newImage("32x32/mur/mur_angle2.png")
imgMap[21] = love.graphics.newImage("32x32/mur/mur_angle3.png")
imgMap[22] = love.graphics.newImage("32x32/mur/mur_angle4.png")
imgMap[23] = love.graphics.newImage("32x32/porte/porte1.png")
imgMap[24] = love.graphics.newImage("32x32/porte/porte2.png")
imgMap[25] = love.graphics.newImage("32x32/porte/porte3.png")
imgMap[26] = love.graphics.newImage("32x32/porte/porte_boss1.png")
imgMap[27] = love.graphics.newImage("32x32/porte/porte_boss2.png")
imgMap[28] = love.graphics.newImage("32x32/porte/porte_boss3.png")
imgMap[29] = love.graphics.newImage("32x32/herbe/herbe_herbe.png")
imgMap[30] = love.graphics.newImage("32x32/herbe/herbe_terre_angle1.png")
imgMap[31] = love.graphics.newImage("32x32/herbe/herbe_terre_angle2.png")
imgMap[32] = love.graphics.newImage("32x32/herbe/herbe_terre_angle3.png")
imgMap[33] = love.graphics.newImage("32x32/herbe/herbe_terre_angle4.png")
imgMap[34] = love.graphics.newImage("32x32/sable.png")
imgMap[35] = love.graphics.newImage("32x32/montagne/montagne1.png")

function CreerPorte(pType, pX, pY, pLargeur, pHauteur)
  local newPorte = {}
  newPorte.x = pX
  newPorte.y = pY
  newPorte.largeur = pLargeur
  newPorte.hauteur = pHauteur

  return newPorte
end

--permet de changer de "salle courante" qui sera representée en vert sur la mini map"
function ChargeSalle(pSalle)

  salleCourante.porte = {}  --permet de vider les portes pour pas cumuler les portes dans la memoire à chaque salle--

  if pSalle.porteHaut == true then
    -- local porte = CreerPorte("porteHaut", largeurEcran/2, 0, 32, 32 )
    local porte = CreerPorte("porteHaut", 288, 0, 32, 32 )
    table.insert(salleCourante.porte, porte)
  end
  if pSalle.porteDroite == true then
    local porte = CreerPorte("porteHaut", largeurEcran-32, 160, 32, 32 )
    table.insert(salleCourante.porte, porte)
  end
  if pSalle.porteBas == true then
    local porte = CreerPorte("porteHaut", 288, hauteurEcran-40, 32, 32 )
    table.insert(salleCourante.porte, porte)
  end
  if pSalle.porteGauche == true then
    local porte = CreerPorte("porteHaut", 0, 160, 32, 32 )
    table.insert(salleCourante.porte, porte)
  end

  salleCourante.salle = pSalle

end  
function DemarreJeu()
  piocheSprite = spriteManager.CreerSprite("pioche_walk",9,0,0)
  piocheSprite.x = 48
  piocheSprite.y = 48
  -- piocheSprite.x = largeurEcran/6
  -- piocheSprite.y = hauteurEcran/6

  donjon.creerDonjon()

  ChargeSalle(donjon.salleDepart)
end

function love.load()
  
  love.window.setTitle( "A pickaxe story (c) 2022 Simon Bénet" )
  love.window.setMode(1920, 1080, {fullscreen=false, vsync=true}) 
  -- love.window.setMode(640, 360, {fullscreen=false, vsync=true}) 

  largeurEcran = 640
  hauteurEcran = 360
  
  DemarreJeu()

  map ={}
    map[1] = { 19,15,15,15,26,15,15,15,15,23,15,15,15,15,15,15,15,15,15,22 }
    map[2] = { 16,0,0,0,0,0,0,29,0,0,0,0,0,0,29,0,0,0,0,18 }
    map[3] = { 16,0,10,6,13,0,0,0,0,0,0,0,0,0,0,0,29,0,0,18 }
    map[4] = { 16,0,7,5,9,0,0,30,1,1,1,1,33,0,0,0,0,0,0,18 }
    map[5] = { 16,0,11,8,12,0,0,2,14,14,14,14,4,0,0,0,0,0,0,18 }
    map[6] = { 24,0,0,0,0,0,0,2,14,14,14,14,4,0,0,0,29,0,0,25 }
    map[7] = { 16,0,29,0,0,0,0,2,14,14,14,14,4,0,34,34,0,0,0,18 }
    map[8] = { 16,0,0,0,0,0,0,2,14,14,14,14,4,0,34,34,0,0,0,18 }
    map[9] = { 16,0,0,29,0,0,0,31,3,3,3,3,32,0,0,0,0,29,0,18 }
    map[10] = { 16,0,35,35,0,0,29,0,0,0,0,0,0,0,0,0,0,0,0,18 }
    map[11] = { 20,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,21 }
  
end

function love.update(dt)
  local ancienX = piocheSprite.x
  local ancienY= piocheSprite.y

  spriteManager.update(dt)
  
    if math.abs(piocheSprite.vx) < 1 and math.abs(piocheSprite.vy) < 1 then
    piocheSprite.frame = 1
    end  

    if love.keyboard.isDown("right") then
        piocheSprite.vx = piocheSprite.vx + 1
        piocheSprite.flip = 1
    end
    if love.keyboard.isDown("d") then
        piocheSprite.vx = piocheSprite.vx + 1
        piocheSprite.flip = 1
    end
    if love.keyboard.isDown("left") then 
        piocheSprite.vx = piocheSprite.vx - 1
        piocheSprite.flip = -1
    end
    if love.keyboard.isDown("q") then 
        piocheSprite.vx = piocheSprite.vx - 1
        piocheSprite.flip = -1
    end
    if love.keyboard.isDown("z") then
        piocheSprite.vy = piocheSprite.vy - 1
        
    end
    if love.keyboard.isDown("up") then
        piocheSprite.vy = piocheSprite.vy - 1
          
    end
    if love.keyboard.isDown("down") then
        piocheSprite.vy = piocheSprite.vy + 1
    end
    if love.keyboard.isDown("s") then
        piocheSprite.vy = piocheSprite.vy + 1
    end
      
    local colonneCollision
    local ligneCollision

    colonneCollision = math.floor((piocheSprite.x / largeurTuille) + 1)
    ligneCollision = math.floor(((piocheSprite.y + piocheSprite.h / 2) / hauteurTuille) +1)
    
    if murs[ligneCollision][colonneCollision] > 0 then
    piocheSprite.x = ancienX
    piocheSprite.y = ancienY
    piocheSprite.vx = 0
    piocheSprite.vy = 0
    end

end

function love.draw()
  love.graphics.scale(3,3)

  for ligne = 1, #map do    
    for colonne = 1, #map[ligne] do  
      love.graphics.draw(imgMap[map[ligne][colonne]], (colonne-1)*32, (ligne-1)*32)
    end
  end  

  local nPorte
  for nPorte = 1, #salleCourante.porte do
    local p = salleCourante.porte[nPorte]
    love.graphics.rectangle("line", p.x, p.y, p.largeur, p.hauteur)
  end  
  
  donjon.dessineDonjon(salleCourante.salle)

  spriteManager.draw()
  --position collision environement--
  -- love.graphics.circle("fill", piocheSprite.x, piocheSprite.y, 1 )

end

function love.keypressed(touche)
  if touche == "escape" then 
  love.event.quit()
  end
end


