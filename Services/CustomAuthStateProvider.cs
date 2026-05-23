using System.Security.Claims;
using System.Net.Http.Headers;
using System.IdentityModel.Tokens.Jwt;
// ⚠️ ¡ESTA LÍNEA ES CRUCIAL! Asegura que herede del componente correcto
using Microsoft.AspNetCore.Components.Authorization; 

namespace FrontBlazor_AppiGenericaCsharp.Services
{
    // Al tener el using de arriba, esta herencia se vuelve válida y el error CS0311 desaparece
    public class CustomAuthStateProvider : AuthenticationStateProvider
    {
        private readonly HttpClient _http;
        private ClaimsPrincipal _usuarioAnonimo = new ClaimsPrincipal(new ClaimsIdentity());
        private string? _jwtToken;
        private List<string> _rolesUsuario = new();

        public CustomAuthStateProvider(HttpClient http)
        {
            _http = http;
        }

        public string? ObtenerTokenActual() => _jwtToken;

public override Task<AuthenticationState> GetAuthenticationStateAsync()
{
    if (string.IsNullOrEmpty(_jwtToken))
    {
        _http.DefaultRequestHeaders.Authorization = null;
        return Task.FromResult(new AuthenticationState(_usuarioAnonimo));
    }

    // Asegura que el cliente HTTP siempre mantenga el Bearer activo al validar el estado
    _http.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", _jwtToken);

    var identidad = new ClaimsIdentity(ParsearClaimsDelJwt(_jwtToken), "jwt");
    var usuario = new ClaimsPrincipal(identidad);

    return Task.FromResult(new AuthenticationState(usuario));
}

public void MarcarComoAutenticado(string token, List<string> roles)
{
    _jwtToken = token;
    _rolesUsuario = roles;

    // 👈 ESTA LÍNEA ES LA SOLUCIÓN: Inyecta el token Bearer en el cliente HTTP de inmediato
    _http.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

    var identidad = new ClaimsIdentity(ParsearClaimsDelJwt(token), "jwt");
    var usuario = new ClaimsPrincipal(identidad);

    NotifyAuthenticationStateChanged(Task.FromResult(new AuthenticationState(usuario)));
}

        public void MarcarComoDesconectado()
        {
            _jwtToken = null;
            _rolesUsuario.Clear();
            _http.DefaultRequestHeaders.Authorization = null;

            NotifyAuthenticationStateChanged(Task.FromResult(new AuthenticationState(_usuarioAnonimo)));
        }

private IEnumerable<Claim> ParsearClaimsDelJwt(string jwt)
        {
            var manejador = new JwtSecurityTokenHandler();
            var tokenJson = manejador.ReadJwtToken(jwt);
            var claimsMapeados = new List<Claim>();

            foreach (var claim in tokenJson.Claims)
            {
                // Si el claim de la API es "role" o "http://schemas.microsoft.com/ws/2008/06/identity/claims/role"
                if (claim.Type == "role" || claim.Type == ClaimTypes.Role)
                {
                    // Lo duplicamos usando el formato estricto que requiere Blazor para las etiquetas <AuthorizeView>
                    claimsMapeados.Add(new Claim(ClaimTypes.Role, claim.Value));
                }
                
                // Mapeamos también el nombre de usuario por si acaso
                if (claim.Type == "unique_name" || claim.Type == ClaimTypes.Name)
                {
                    claimsMapeados.Add(new Claim(ClaimTypes.Name, claim.Value));
                }

                // Conservamos el claim original para mantener la compatibilidad intacta
                claimsMapeados.Add(claim);
            }

            return claimsMapeados;
        }
}
}