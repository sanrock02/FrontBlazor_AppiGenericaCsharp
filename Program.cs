using FrontBlazor_AppiGenericaCsharp.Components;

var builder = WebApplication.CreateBuilder(args);

// Agregar servicios de Blazor Server
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

// Configurar HttpClient para conectarse a la API
// El HttpClient se usa desde el navegador (InteractiveServer)
// por lo que necesita la URL completa y absoluta de la API
builder.Services.AddScoped(sp =>
{
    var httpClient = new HttpClient();
    // URL absoluta porque las solicitudes se hacen desde el navegador
    httpClient.BaseAddress = new Uri("http://localhost:5034");
    return httpClient;
});

// Registrar el servicio generico de la API
builder.Services.AddScoped<FrontBlazor_AppiGenericaCsharp.Services.ApiService>();
builder.Services.AddScoped<FrontBlazor_AppiGenericaCsharp.Services.SpService>();

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
