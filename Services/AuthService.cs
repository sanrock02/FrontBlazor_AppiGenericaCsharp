using System.Net.Http.Json;
using System.Text.Json;
using System.Text.Json.Serialization; 
using Microsoft.AspNetCore.Components.Authorization;

namespace FrontBlazor_AppiGenericaCsharp.Services
{
    public class AuthService
    {
        private readonly HttpClient _http;
        private readonly IServiceProvider _serviceProvider; // 👈 Rompe la referencia circular usando el proveedor de servicios

        public AuthService(HttpClient http, IServiceProvider serviceProvider)
        {
            _http = http;
            _serviceProvider = serviceProvider;
        }

        public async Task<(bool exito, string mensaje)> LoginAsync(string usuario, string contrasena)
        {
            try
            {
                var userClean = usuario.Trim();
                var passClean = contrasena.Trim();

                // 1. CORREGIDO: Llaves en PascalCase idénticas a como funcionó en Swagger
                var jsonString = $"{{\"Tabla\":\"usuarios\",\"CampoUsuario\":\"email\",\"CampoContrasena\":\"password_hash\",\"Usuario\":\"{userClean}\",\"Contrasena\":\"{passClean}\"}}";
                
                var contenido = new StringContent(jsonString, System.Text.Encoding.UTF8, "application/json");

                // Enviamos a la API
                var respuesta = await _http.PostAsync("/api/Autenticacion/token", contenido);

                if (!respuesta.IsSuccessStatusCode)
                {
                    try
                    {
                        var errorData = await respuesta.Content.ReadFromJsonAsync<Dictionary<string, object>>();
                        if (errorData != null && errorData.ContainsKey("mensaje"))
                        {
                            return (false, errorData["mensaje"]?.ToString() ?? "Credenciales incorrectas.");
                        }
                    }
                    catch { }

                    return (false, "Usuario o contraseña incorrectos.");
                }

                // Mapeo de la respuesta exitosa
                var resultado = await respuesta.Content.ReadFromJsonAsync<LoginResult>();
                
                if (resultado != null && !string.IsNullOrEmpty(resultado.Token))
                {
                    var roles = resultado.Roles ?? new List<string> { "Administrador" };
                    
                    // 2. CORREGIDO: Resolvemos el AuthStateProvider bajo demanda para evitar el bloqueo del ciclo de dependencias
                    var authStateProvider = _serviceProvider.GetService<AuthenticationStateProvider>() as CustomAuthStateProvider;
                    
                    if (authStateProvider != null)
                    {
                        authStateProvider.MarcarComoAutenticado(resultado.Token, roles);
                    }
                    
                    return (true, "Ingreso exitoso.");
                }

                return (false, "Error al procesar la respuesta del servidor.");
            }
            catch (Exception ex)
            {
                return (false, $"Error de conexión: {ex.Message}");
            }
        }

public void Logout()
{
    // Resolvemos el proveedor de estado bajo demanda para limpiar el token
    var authStateProvider = _serviceProvider.GetService<AuthenticationStateProvider>() as CustomAuthStateProvider;
    
    if (authStateProvider != null)
    {
        // Borra el JWT, limpia los encabezados HTTP y notifica a la interfaz
        authStateProvider.MarcarComoDesconectado();
    }
}
    }

    public class LoginResult
    {
        [JsonPropertyName("token")]
        public string Token { get; set; } = string.Empty;

        [JsonPropertyName("roles")]
        public List<string> Roles { get; set; } = new();
    }
}