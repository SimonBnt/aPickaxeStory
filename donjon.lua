local donjon = {}
donjon.nombreColonne = 9
donjon.nombreLigne = 6
donjon.salleDepart = nil
donjon.grid = {}

local function CreerSalle(pLigne,pColonne)
  local newSalle = {}
  
  newSalle.ligne = pLigne
  newSalle.colonne = pColonne
  
  newSalle.Ouverte = false
  
  newSalle.porteHaut = false
  newSalle.porteDroite = false
  newSalle.porteBas = false
  newSalle.porteGauche = false
  
  return newSalle
end

local largeurEcran
local hauteurEcran

largeurEcran = love.graphics.getWidth()
hauteurEcran = love.graphics.getHeight()

donjon.creerDonjon = function()
  donjon.grid = {}
  
  local nLigne,nColonne
  for nLigne=1,donjon.nombreLigne  do
    donjon.grid[nLigne] = {}
    for nColonne=1,donjon.nombreColonne do
      donjon.grid[nLigne][nColonne] = CreerSalle(nLigne,nColonne)
    end
  end
  
  -- Génère le donjon
  
  local listeSalles = {}
  local nbSalles = 12
  
  -- Crée la salle de départ
  local nLigneDepart,nColonneDepart
  nLigneDepart = math.random(1, donjon.nombreLigne )
  nColonneDepart = math.random(1, donjon.nombreColonne)
  local salleDepart = donjon.grid[nLigneDepart][nColonneDepart]
  salleDepart.Ouverte = true
  table.insert(listeSalles,salleDepart)
  -- Mémoriser la salle de départ
  donjon.salleDepart = salleDepart
  
  while #listeSalles < nbSalles do
    
    -- Sélectionne une salle dans la liste
    local nSalle = math.random(1, #listeSalles)
    local nLigne = listeSalles[nSalle].ligne
    local nColonne = listeSalles[nSalle].colonne
    local salle = listeSalles[nSalle]
    local nouvelleSalle = nil
    
    local direction = math.random(1,4)
    
    local ajouteSalle = false

    if direction == 1 and nLigne > 1 then
      -- Haut
      nouvelleSalle = donjon.grid[nLigne-1][nColonne]
      if nouvelleSalle.Ouverte == false then
        salle.porteHaut = true
        nouvelleSalle.porteBas = true
        ajouteSalle = true
      end
    elseif direction == 2 and nColonne < donjon.nombreColonne then
      -- Droite
      nouvelleSalle = donjon.grid[nLigne][nColonne+1]
      if nouvelleSalle.Ouverte == false then
        salle.porteDroite = true
        nouvelleSalle.porteGauche = true
        ajouteSalle = true
      end
    elseif direction == 3 and nLigne < donjon.nombreLigne  then
      -- Bas
      nouvelleSalle = donjon.grid[nLigne+1][nColonne]
      if nouvelleSalle.Ouverte == false then
        salle.porteBas = true
        nouvelleSalle.porteHaut = true
        ajouteSalle = true
      end
    elseif direction == 4 and nColonne > 1 then
      -- Gauche
      nouvelleSalle = donjon.grid[nLigne][nColonne-1]
      if nouvelleSalle.Ouverte == false then
        salle.porteGauche = true
        nouvelleSalle.porteDroite = true
        ajouteSalle = true
      end
    end
    
    -- Ajoute la salle
    if ajouteSalle == true then
        nouvelleSalle.Ouverte = true
        table.insert(listeSalles, nouvelleSalle)      
    end
    
  end
  
end

donjon.dessineDonjon = function(pSalle)
    local x,y 
    x = 0
    y = 5
    local largeurCase = 6
    local hauteurCase = 4
    local espaceCase = 2
    local nLigne, nColonne

    
    for nLigne = 1, donjon.nombreLigne do
        x= 560
        for nColonne = 1, donjon.nombreColonne do
            local salle = donjon.grid[nLigne][nColonne]    --variable tampon dans laquel on stock la salle ce qui permet de la manipuler plus facilement-- 
                    --dessine la grille--
            if salle.Ouverte == false then  --Si les case de la grid à l'emplacement ligne et colonne ne sont pas "ouverte" alors dessiner les cases en gris-- 
                love.graphics.setColor(0.2,0.2,0.2)       --alors dessine les case en gris--
                love.graphics.rectangle("fill", x, y, largeurCase, hauteurCase) --dessine les cases--
            else                                          --sinon--              
                if pSalle == salle then         --Si c' la salle de dapart du donjon-- 
                love.graphics.setColor(0.2,1,0.2)       --alors dessine les case en vert--
                else                                    --sinon--
                    love.graphics.setColor(1,1,1)       --alors dessine les case en blanc--
                end    
                love.graphics.rectangle("fill", x, y, largeurCase, hauteurCase) --dessine les cases en blanc--
                --dessine les chemins entre salle--
                love.graphics.setColor(1,0.6,0.4)
                if salle.porteHaut == true then         --Si il y a une salle ouverte vers le haut alors dessine le chemin--
                    love.graphics.rectangle("fill" , (x+largeurCase/2) , y, 1, 1)
                end    
                if salle.porteDroite == true then
                    love.graphics.rectangle("fill" , (x+largeurCase -1) , (y+hauteurCase/2), 1, 1)
                end    
                if salle.porteBas == true then
                    love.graphics.rectangle("fill" , (x+largeurCase/2) , (y+hauteurCase - 1), 1, 1)
                end    
                if salle.porteGauche == true then 
                    love.graphics.rectangle("fill" , (x), (y+hauteurCase/2), 1, 1)
                end    
                love.graphics.setColor(1,1,1)       --alors dessine les case en blanc--
            end   
            x = x + largeurCase + espaceCase
        end 
        y = y + hauteurCase + espaceCase
        
    end  
    love.graphics.setColor(1,1,1)    --apres chaque parcour de boucle reset les couleurs en blanc

end

return donjon