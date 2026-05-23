using System.Data;
using Microsoft.Data.SqlClient;

namespace FrontBlazor_AppiGenericaCsharp.Services
{
    public class SpService
    {
        private readonly string _connectionString;

        public SpService(IConfiguration configuration)
        {
            // Lee la cadena de conexión desde el archivo appsettings.json
            _connectionString = configuration.GetConnectionString("DefaultConnection") ?? "";
        }

        public async Task<(bool exito, List<Dictionary<string, object?>> resultados, string mensaje)> EjecutarSpAsync(string nombreSp, Dictionary<string, object?>? parametros = null)
        {
            var resultados = new List<Dictionary<string, object?>>();
            try
            {
                using var conexion = new SqlConnection(_connectionString);
                using var comando = new SqlCommand(nombreSp, conexion);
                comando.CommandType = CommandType.StoredProcedure;

                if (parametros != null)
                {
                    foreach (var p in parametros)
                    {
                        comando.Parameters.AddWithValue(p.Key, p.Value ?? DBNull.Value);
                    }
                }

                await conexion.OpenAsync();
                using var reader = await comando.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    var fila = new Dictionary<string, object?>();
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        fila[reader.GetName(i)] = reader.IsDBNull(i) ? null : reader.GetValue(i);
                    }
                    resultados.Add(fila);
                }

                return (true, resultados, "Operación exitosa");
            }
            catch (Exception ex)
            {
                return (false, resultados, ex.Message);
            }
        }
    }
}