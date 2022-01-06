# Un Menu de control para vehiculos utilizando qb-menu y qb-radialmenu


## Imagenes
https://cdn.discordapp.com/attachments/845214568850522124/928733925948391434/1.png
https://cdn.discordapp.com/attachments/845214568850522124/928733926460117042/2.png
https://cdn.discordapp.com/attachments/845214568850522124/928733927093465119/3.png
https://cdn.discordapp.com/attachments/845214568850522124/928733927596765194/4.png
https://cdn.discordapp.com/attachments/845214568850522124/928734376357945364/6.png


## Notas

- Asegúrese de tener la última versión de qb-core, qb-menu y qb-radialmenu para que todo funcione sin problemas.
- Este recurso es una edicion del original, modificando algunas funciones como abrir puertas, activar extras, activar/desactivar neones directamente sin necesidad 
  de abrir el menu de neones entre otras funciones que ya venian incluidas en el qb-radialmenu del Framework y no era necesario tenerlas en el menu de control vehicular, 
  de esta manera se podra tener un menu mas limpio y sencillo para el usuario.



## Dependencias / Requisitos :

Marco de QBCore - https://github.com/qbcore-framework/qb-core

qb-menu - https://github.com/qbcore-framework/qb-menu 

qb-radialmenu - https://github.com/qbcore-framework/qb-radialmenu


## Creditos : 

- `Kakarot`  qb-menu, qb-core framework, qb-radialmenu
- `Pawsative`  Nativos con funciónes de luz de neones
- `IN1GHTM4R3` qb-carcontrol

-----------------------------------------------------------------------------------------------------------------

## Este recurso simplemente incluye un fxmanifest.lua y un main.lua, si desea agregarlo a un recurso ya creado en su servidor, puede agregarlo directamente a
## qb-smallresources creando un nuevo archivo "cl_carcontrol.lua" y pegando todo el codigo del main.lua de qb-carcontrol dentro, tambien podra agregarlo en cualquier
## client.lua que tenga en el servidor o donde tenga varios recursos en uno.

`Para agregar el boton de control a su menu radial, debera ir al recurso qb-radialmenu/config.lua, y dentro del menu vehicular debera agregar este fragmento`

```
       	   {
                id = 'vehiclemenu',
                title = 'Controles',
                icon = 'bars',
                type = 'client',
                event = 'ccvehmenu:client:openMenu',
                shouldClose = true
            }
```
`El fragmento de arriba debera ser agregado en cualquier parte dentro de los {} de items como se aprecia en el siguiente fragmento y debera quedar asi`

``` 
    [3] = {
        id = 'vehicle',
        title = 'Vehiculo',
        icon = 'car',
        items = {
            {
                id = 'vehiclemenu',
                title = 'Controles',
                icon = 'bars',
                type = 'client',
                event = 'ccvehmenu:client:openMenu',
                shouldClose = true
            }
        {
    },
    [4] = {
        id = 'jobinteractions',
        title = 'Trabajo',
        icon = 'briefcase',
        items = {}
    }
``` 

