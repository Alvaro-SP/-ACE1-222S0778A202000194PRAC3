<p>UNIVERSIDAD DE SAN CARLOS DE GUATEMALA</p>
<p>FACULTAD DE INGENIERIA</p>
<p>ESCUELA DE CIENCIAS Y SISTEMAS</p>
<p>LABORATORIO DE ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1</p>
<p>SEGUNDO SEMESTRE 2022</p>
<p>ING. OTTO RENE ESCOBAR LEIVA</p>
<p>TUTOR ACADEMICO SECCION A. OSCAR PERALTA</p>

---


---


---


---


---


---


---

<center> <h1>PRACTICA #3</h1> </center>
<center> <h1>JUEGO BATTLESHIP</h1> </center>



---


---


---


---




| Nombre   |      Carnet      |  
|----------|:-------------:|
| Alvaro Emmanuel Socop Pérez | 202000194 | 

---


---


---


---




---


---


---


---


---

# <a name="nothing"></a>MANUAL DE USUARIO
Este documento contiene toda la información sobre los recursos utilizados por el programa para poder jugarlo, explicando todo el trabajo que se ha realizado al crear el juego de Laberinto el uso adecuado que usted como usuario debe darle , explicado paso a paso.

>“Programa desarrollado en ASSEMBLER.                                                                                                                .”
## <a name="intro" ></a>ÍNDICE

| Topico | Link |
| ------ | ------ |
| Introducción | [Ir](#intro) |
| Información del sistema | [Ir](#inf) |
| Objetivos y alcances del sistema| [Ir](#ob) |
| Información del Sistema requerido | [Ir](#sis) |
| Sistema Operativo | [Ir](#sis) |
| Tecnologías utilizadas | [Ir](#tech) |
| Interfaz del programa | [Ir](#inter) |
| Conclusiones | [Ir](#Conclu) |
## <a name="intro" ></a>INTRODUCCIÓN
El presente manual de usuario tiene como finalidad describir la estructura y diseño del programa Laberinto que se realizo como parte de Practica 3, así como dar explicación hacia los usuarios de como pueden ejecutar y jugar en su casa. El sistema cuenta con implementación de varias librerías propias de Arduino Online como parte del conocimiento adquirido en los laboratorios de arquitectura de ensambladores y computadores 1, en base a ello tratarémos de explicar como ejecutar el juego para poder disfrutarlo.


## <a name="inf"></a>Informacion del Sistema
El juego de acorazado es el clásico juego de combate naval que reúne la competencia, la estrategia y la emoción! En la batalla cara a cara, los jugadores buscan la flota de barcos enemigos y los destruyen uno por uno.

- Con prácticos casos de batalla portátiles y artesanías navales de aspecto realista, el juego de acorazado pone a los jugadores justo en medio de la acción.

- Juega cuando y donde quiera
- Fregar las naves del oponente para la victoria
- Rastrear barcos enemigos en la cuadrícula objetivo
- Llame a un disparo y fuego
## <a name="ob"></a>Objetivos y alcances del sistema

### Objetivo General
- Que el estudiante aplique los conocimientos adquiridos en el curso sobre el lenguaje ensamblador

### Objetivos Específicos
- Aplicar el conocimiento de operaciones básicas a nivel ensamblador.
- Conocer el funcionamiento de las interrupciones.
- Comprender el uso de la memoria en los programas escritos en ensamblador.
- Aplicar el manejo de archivos a bajo nivel.
- Comprender el uso de registros bandera.

## <a name="sis"></a>Especificaciones del Sistema requerido


### <a name="sis"></a>Requisitos de Hardware
|  |  |
| ------ | ------ |
|Memoria mínima|	512 MB|
|Memoria recomendada |	1 GB|
|Espacio en disco mínimo|	250 MB de espacio libre  |
|Espacio en disco recomendado	|  500 MB de espacio libre|
|MVP	|Visual Studio Code y MASM instalados |

### <a name="sis"></a>Requisitos de software
## <a name="sis"></a>Sistema operativo 
Windows
-	Windows 10 (8u51 y superiors)
-	Tener instalado el programa de Proteus y Librerias de Arduino Code u otro editor
-	RAM: 128 MB
-	Espacio en disco: 124 MB 
-	Procesador: Mínimo Pentium 2 a 266 MHz 
-	Algún explorador de internet Mac OS X 
-	Tener instalado el programa Visual Studio Code y DOSBOX con MASM
-	Explorador de 64 bits 
-	Se requiere un explorador de 64 bits (Safari, Firefox, por ejemplo) para ejecutar Oracle Java en Mac OS X. Linux
-	Oracle Linux 5.5+1 
-	Oracle Linux 6.x (32 bits), 6.x (64 bits)2 
-	Exploradores: Firefox
-	Arduino
-	Proteus



## <a name="tech"></a>Tecnologías 
- Assembler es tipo de programa informático que se encarga de traducir un fichero fuente escrito en un lenguaje ensamblador, a un fichero objeto que contiene código máquina, ejecutable directamente por el microprocesador.

- MASM es El Microsoft Macro Assembler (MASM) es un ensamblador para la familia x86 de microprocesadores. Fue producido originalmente por Microsoft para el trabajo de desarrollo en su sistema operativo MS-DOS, y fue durante cierto tiempo el ensamblador más popular disponible para ese sistema operativo. 

## <a name="inter"></a>Interfaz Utilizada
En la interfaz utilizada podemos encontrar diferentes enlementos que nos ayudan con el funcionamiento integro del juego, entre los cuales podemos encontrar los siguientes: 

- <span style="color:green">AREA DE ENTRADA DE BARCOS:</span> Igresara los barcos por medio de coordenadas mostradas y su posicion en el tablero
- <span style="color:green">INICIO DEL JUEGO:</span> se muestran 2 planos los cuales muestran los disparos realizados y barcos en el tablero
- <span style="color:green">FIN DEL JUEGO:</span> se muestra quien es el ganador de la partida

<p align="center">
  <a href="#"><img src="a1.png"/></a>
</p>
<p align="center">
  <a href="#"><img src="a2.png"/></a>
</p>
<p align="center">
  <a href="#"><img src="a3.png"/></a>
</p>
<p align="center">
  <a href="#"><img src="a4.png"/></a>
</p>
<p align="center">
  <a href="#"><img src="a5.png"/></a>
</p>
<p align="center">
  <a href="#"><img src="a6.png"/></a>
</p>
<p align="center">
  <a href="#"><img src="a7.png"/></a>
</p>
<p align="center">
  <a href="#"><img src="a8.png"/></a>
</p>


REPORTES
<p align="center">
  <a href="#"><img src="a9.png"/></a>
</p>
<p align="center">
  <a href="#"><img src="a10.png"/></a>
</p>


## <a name="Conclu"></a>Conclusiones

- Como conclusión podemos decir que el lenguaje ensamblador es mas que un tipo de lenguaje de bajo nivel en el cual es empleado para crear programas informáticos.

- •La importancia de este es que en el se pueden hacer cualquier tipo de programas que en otros lenguajes de alto nivel no, al igual que ocupan menos espacio en la memoria.

- Este lenguaje es creado a base de instrucciones para intentar sustituir al lenguaje maquina por uno similar utilizado por el hombre.