class Canvas
  attr_accessor :ancho,:alto, :canvas

  def initialize(ancho, alto)
    @ancho=ancho+2
    @alto=alto+2
    @canvas = canvas=[]
  end

  def create_canvas
    ancho.times do
      canvas.push([])
    end
    for i in 0...alto
      for j in 0...ancho
        canvas[i][j]=" "
        if i==0
            canvas[i][j]="-"
            next
        end
        if i==alto-1
            canvas[i][j]="-"
            next
        end
        if j==0
          canvas[i][j]="|"
          next
        end
        if j==ancho-1
          canvas[i][j]="|"
          next
        end
      end
    end
  end


  def dibuar_canvas
    for i in 0...alto
      for j in 0...ancho
        print " #{canvas[i][j]} "
      end
      puts ""
    end
  end

  def dibuar_linea(x1, y1, x2, y2)
    if x1==x2 || y1==y2
      if x1==x2
        negativo=false
        tamanio_linea=(y1-y2)

        if tamanio_linea<=0
          negativo=true
          tamanio_linea=(y1-y2).abs
        end

        i=0
        (tamanio_linea+1).times do
          unless negativo
            canvas[y1+i][x1]="X"
            i-=1
          else
            canvas[y1+i][x1]="X"
            i+=1
          end
        end
      else

        negativo=false
        tamanio_linea=(x1-x2)

        if tamanio_linea<=0
          negativo=true
          tamanio_linea=(x1-x2).abs
        end

        i=0
        (tamanio_linea+1).times do

          unless  negativo
            canvas[y1][x1+i]="X"
            i-=1
          else

            canvas[y1][x1+i]="X"
            i+=1
          end
        end
      end
    else
      puts "no son puntos validos para una linea"
    end
  end

  def dibujar_rectangulo(x1, y1, x2, y2)

    dibuar_linea(x1, y1, x1, y2)
    dibuar_linea(x2, y1, x2, y2)
    dibuar_linea(x1, y1, x2, y1)
    dibuar_linea(x1, y2, x2, y2)
  end


  def bucket_fill(y, x, c)

    color_original=canvas[x][y]
    visitados =[]
    pila =Array.new
    cordenada= [x,y]

    visitados.push(cordenada)
    pila.push(cordenada)

    while !pila.empty?

      xy= pila.pop
      x=xy[0]
      y=xy[1]

      if canvas[x][y]==color_original && x>0 && y>0
        unless visitados.include?([x+1,y]) || x>alto
            pila.push([x+1,y])
        end
        unless visitados.include?([x-1,y]) || x<=0
            pila.push([x-1,y])
        end
        unless visitados.include?([x,y+1]) || y>ancho
            pila.push([x,y+1])
        end
        unless visitados.include?([x,y-1]) || y<=0
            pila.push([x,y-1])
        end
        canvas[x][y]=c
        visitados.push([x,y])
      end
    end
  end
end

class App

  puts "................LISTA DE COMANDOS.............."
  puts ""
  puts "Crear nuevo canvas con ancho w y altura h:.....C w h"
  puts "dibujar linea  punto de inicio y fin:..........L x1 y1 x2 y2"
  puts "Dibujar rectangulo punto inicio y fin:.........R x1 y1 x2 y2"
  puts "Colorear espacio punto de inicio:..............B x y c"
  puts "salir: ........................................Q"

  salir=false

  while !salir
    puts "escriba comando"
    entrada= gets.chomp
    comando=[]
    comando=entrada.split(" ")

    case comando[0]
    when "C"
      dibujo = Canvas.new(comando[1].to_i,comando[2].to_i)
      dibujo.create_canvas
      dibujo.dibuar_canvas
    when "L"
      dibujo.dibuar_linea(comando[1].to_i,comando[2].to_i,comando[3].to_i,comando[4].to_i)
      dibujo.dibuar_canvas
    when "R"
      dibujo.dibujar_rectangulo(comando[1].to_i,comando[2].to_i,comando[3].to_i,comando[4].to_i)
      dibujo.dibuar_canvas
    when "B"
      dibujo.bucket_fill(comando[1].to_i, comando[2].to_i, comando[3])
      dibujo.dibuar_canvas
    when "Q"
      puts "chao"
      salir=true
    else
      puts "Este comando no existe"
    end

  end
end

App.new()
