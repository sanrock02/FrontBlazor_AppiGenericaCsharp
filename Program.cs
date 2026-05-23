using FrontBlazor_AppiGenericaCsharp.Components;
using Microsoft.AspNetCore.Components.Authorization;

var builder = WebApplication.CreateBuilder(args);

// Agregar servicios de Blazor Server
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

// Configurar HttpClient para conectarse a la API
// El HttpClient se usa desde el navegador (InteractiveServer)
// por lo que necesita la URL completa y absoluta de la API (Puerto 5035)
// Configurar HttpClient para conectarse a la API
builder.Services.AddScoped(sp =>
{
    var httpClient = new HttpClient();
    httpClient.BaseAddress = new Uri("http://localhost:5035");
    return httpClient;
});

// ─────────────────────────────────────────────────────────────────
// CONFIGURACIÓN DE SEGURIDAD, PROVEEDORES Y SERVICIOS (ORDEN ESTRICTO)
// ─────────────────────────────────────────────────────────────────
builder.Services.AddCascadingAuthenticationState();
builder.Services.AddAuthorizationCore();

// 1. Proveedor de Estado de Autenticación
builder.Services.AddScoped<Microsoft.AspNetCore.Components.Authorization.AuthenticationStateProvider, FrontBlazor_AppiGenericaCsharp.Services.CustomAuthStateProvider>();

// 2. Servicio de Autenticación (¡Este es el que está reclamando el NavMenu!)
builder.Services.AddScoped<FrontBlazor_AppiGenericaCsharp.Services.AuthService>();

// 3. Servicios Genéricos de Datos
builder.Services.AddScoped<FrontBlazor_AppiGenericaCsharp.Services.ApiService>();
builder.Services.AddScoped<FrontBlazor_AppiGenericaCsharp.Services.SpService>();
// ─────────────────────────────────────────────────────────────────
var app = builder.Build();

// Configurar el pipeline HTTP.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
}

app.UseAntiforgery();

app.MapStaticAssets();
app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();