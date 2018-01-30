using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Seguridad;
namespace WebApplication1.Aplicativo
{
    public static class Cripto
    {
        private static Seguridad.Encriptacion encriptador = new Encriptacion();

        public static string Encriptar(string valor)
        {
            string ret = string.Empty;

            if (valor == string.Empty)
            {
                ret = "contenido nulo";
            }
            else
            {
                encriptador.Contenido = valor;

                encriptador.Encriptar();

                ret = encriptador.Resultado;
            }

            return ret;
        }

        //public static string Desencriptar(string valor)
        //{
        //    string ret = string.Empty;

        //    encriptador.Contenido = valor;

        //    encriptador.Desencriptar();

        //    ret = encriptador.Resultado;

        //    return ret;
        //}

    }
}