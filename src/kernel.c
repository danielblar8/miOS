//puntero a la direccion de la pantalla casteado a short
unsigned short *ptr = (unsigned short*)0xB8000;
// Imprimir texto en pantalla
// Color = 0x0F
//         │ └→ 0xF = 15 = blanco (texto)
//         └──→ 0x0 = 0  = negro  (fondo)
void print_char(char c, int fila, int columna, unsigned char color){
    
    int index = fila * 80 + columna;
    ptr[index] = (color << 8)| c;

}

void clear_screen(){
    for (int i = 0; i < 2000; i++)
    {
        ptr[i] = (0x0F << 8) | ' ';
    }
    
}

// Inicializacion, aqui se aceptan las cosas que se mostraran
void kernel_main(){
    clear_screen();
    print_char('H', 2, 0, 0x0F);
    
    
    //
    while (1){

    }
}

