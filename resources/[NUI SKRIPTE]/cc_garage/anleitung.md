# BTW This Script was Leaked by Luxury Leaks
# Anleitung zur Bearbeitung der Garagen

In der server/main.lua findest du auf Zeile 125 einen Codeblock der garages heisst und da drunter einen der coordinate heisst

Zwei Nachkommastellen reichen bei den Koordinaten

## coordinate

-> Einstellungen zum npc

Syntax:
`{ 275.182, -345.534, 45.173, nil, 284.43, nil, 216536661},`

1. X-Koordinate
2. Y-Koordinate
3. Z-Koordinate
4. nil lassen
5. Heading (Blickrichtung)
6. nil lassen
7. Hash vom NPC

## garages

-> Einstellungen zur Garage

Syntax:
`{vector3(275.182, -345.534, 45.173), vector3(266.498, -332.475, 43.43), 251.0, true}`

1. Punkt zum ausparken (vor dem npc) -> vector3(X-Koordinate, Y-Koordinate, Z-Koordinate)
2. Punkt wo das Auto spawnt -> vector3(X-Koordinate, Y-Koordinate, Z-Koordinate)
3. Heading -> Blickrichtung in der das Auto spawnt
4. Blip anzeigen? *true* / *false*