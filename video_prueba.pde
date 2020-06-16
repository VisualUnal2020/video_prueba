import processing.video.*;
Movie video_clip;

// VARIABLE PARA LOS FOTOGRAMAS DEL VIDEO
PGraphics fotograma_original;
PGraphics fotograma_grises;

String nombre_archivo = "video_prueba_01.mp4";

void setup() {
    size(1310, 380);
    fotograma_original    = createGraphics(640, 360);
    fotograma_grises      = createGraphics(640, 360);
    video_clip = new Movie(this, nombre_archivo);
    video_clip.loop();
}

void draw() {
    video_original();
    escala_grises(fotograma_original, fotograma_grises);
}

// PERMITE CORRER(LEER) EL VIDEO
void movieEvent(Movie m) {
    m.read();
}

// PINTA EL VIDEO ORIGINAL EN LA PARTE IZQUIERZA DEL CANVAS
void video_original(){
    fotograma_original.beginDraw();
    fotograma_original.image(video_clip, 0, 0);
    fotograma_original.endDraw();
    image(fotograma_original, 10, 10);
}

// PINTA EL VIDEO CONVERTIDO EN ESCALA DE GRISES EN LA PARTE DERECHA DEL CANVAS
void escala_grises(PGraphics fotograma, PGraphics grises){
    fotograma_grises.beginDraw();
    fotograma_grises.image(video_clip, 0, 0);
    fotograma_grises.loadPixels();
    fotograma_grises = opcion_convertir_escala_grises(fotograma);
    fotograma_grises.updatePixels();
    fotograma_grises.endDraw();
    image(grises, 660, 10);
}

// CARGA EL FOTOGRAMA, RECORRE CADA PIXEL Y REALIZA LA CONVERSION A ESCALA DE GRIS
// SEGUN LA OPCION DIGITA EN EL TECLADO
PGraphics opcion_convertir_escala_grises(PGraphics fotograma) {
    PGraphics fotograma_grises = fotograma;
    fotograma.loadPixels();
    for (int y = 0; y < fotograma.height; y++) {  
        for (int x = 0; x < fotograma.width; x++) {
            int recuperar_posicion = x + (y * fotograma.width);
            float color_gris = 0;
            color_gris = ((0.21)*(red(fotograma.pixels[recuperar_posicion])) + ((0.72)*green(fotograma.pixels[recuperar_posicion])) + ((0.07)*blue(fotograma.pixels[recuperar_posicion])));
            fotograma_grises.pixels[recuperar_posicion] = color(color_gris, color_gris, color_gris);
        }
    }
    fotograma_grises.updatePixels();
    return fotograma_grises;
}