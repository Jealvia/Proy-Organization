#include <stdio.h>
#include <stdlib.h>
 
#define MAX 99
 
void push( int*, int*, int );
int pop( int*, int* );
int altura( int* );
void mostrarPila(int*,int*);
int main( )
{
    printf("Hola ashdbasdh\n");
    int elementos = 0;
    int pila[MAX];
    int bandera=0;
    
    

    while(bandera==0){
        int numero,operacion;
        printf("1.Agregar elemento \n");
        printf("2.Sacar elemento \n");
        printf("3.Numero de elemntos \n");
        printf("4.Operaciones con dos elementos de una pila (El resultado se reingresa en la pila)\n");
        printf("5.Mostrar pila\n");
        printf("6.Salir\n");
        printf("Ingrese una opcion: ");
        scanf("%d",&numero);
        if (numero==1)
        {
            int num;
            printf("Ingrese valor: ");
            scanf("%d",&num);
            push( pila, &elementos, num );
            
        }else if (numero==2)
        {
            if (elementos>=1)
            {
                printf( "pop: %d\n", pop( pila, &elementos ) );
            }else{
                printf("No quedan elementos en la pila\n");
            }
            
        }else if (numero==3)
        {
            printf( "Numero de elementos:%d\n", altura( &elementos ) );
            
        }else if (numero==4)
        {
            if (altura(&elementos)>=2)
            {
                int band=0;
            while(band==0){
                printf("1.Sumar\n");
                printf("2.Restar\n");
                printf("3.Multiplicar\n");
                printf("4.Dividir\n");
                printf("Ingrese una opcion\n");
                scanf("%d",&operacion);
                if (operacion>4 && operacion<0)
                {
                    printf("Ingrese una opcion valida\n");
                }else{
                    band=5;
                }
            }
            if (operacion==1)
            {
                int temp=pop( pila, &elementos );
                int temp1=pop( pila, &elementos );
                int op=temp+temp1;
                push( pila, &elementos, op );
                printf("Suma: %d + %d = %d \n",temp,temp1,op );
            }else if (operacion==2)
            {
                int temp=pop( &(*pila), &elementos );
                int temp1=pop( &(*pila), &elementos );
                int op=temp-temp1;
                push( pila, &elementos, op );
                printf("Resta: %d - %d = %d \n",temp,temp1,op );
            }else if (operacion==3)
            {
                int temp=pop( &(*pila), &elementos );
                int temp1=pop( &(*pila), &elementos );
                int op=temp*temp1;
                push( pila, &elementos, op );
                printf("Multiplicar: %d * %d = %d \n",temp,temp1,op );
            }else if (operacion==4)
            {
                int temp=pop( &(*pila), &elementos );
                int temp1=pop( &(*pila), &elementos );
                int op=temp/temp1;
                push( pila, &elementos, op );
                printf("Dividir: %d / %d = %d \n",temp,temp1,op );
            }
            }else{
                printf("Numero de elementos insuficientes\n");
            }
            
        }else if (numero==5)
        {
            if (altura(&elementos)>0)
            {
                mostrarPila(pila,&elementos);
            }
        }else if (numero==6)
        {
            bandera=5;
        }else{
            printf("Ingrese una opcion valida\n");
        }
        
    }
    return 0;
}
 
void push( int pila[], int *elementos, int num )
{
    pila[*elementos]=num;
    ++(*elementos);
}
 
int pop( int pila[], int *elementos )
{
        int num;
        num = pila[*elementos-1];
        --(*elementos);
        return num;

    
}
 
 void mostrarPila(int pila[],int *elementos){
    printf("EEntro ysuysdfb\n");
    for (int i = *elementos-1; i >= 0; --i)
    {
        printf("%d\n",pila[i] );
    }
 }

int altura( int *elementos )
{
    return (*elementos);
}

