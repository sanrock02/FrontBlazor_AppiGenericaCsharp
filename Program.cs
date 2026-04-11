using FrontBlazor_AppiGenericaCsharp.Components;

var builder = WebApplication.CreateBuilder(args);

// Agregar servicios de Blazor Server
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

// Configurar HttpClient para conectarse a la API
<<<<<<< HEAD
// La URL base apunta a la API ApiGenericaCsharp que corre en el puerto 5034
builder.Services.AddScoped(sp => new HttpClient
{
    BaseAddress = new Uri("http://localhost:5034")
=======
// El HttpClient se usa desde el navegador (InteractiveServer)
// por lo que necesita la URL completa y absoluta de la API
builder.Services.AddScoped(sp =>
{
    var httpClient = new HttpClient();
    // URL absoluta porque las solicitudes se hacen desde el navegador
    httpClient.BaseAddress = new Uri("http://localhost:5035");
    return httpClient;
>>>>>>> 0fa103b (Subiendo mi proyecto terminado)
});

// Registrar el servicio generico de la API
builder.Services.AddScoped<FrontBlazor_AppiGenericaCsharp.Services.ApiService>();
<<<<<<< HEAD
=======
builder.Services.AddScoped<FrontBlazor_AppiGenericaCsharp.Services.SpService>();
>>>>>>> 0fa103b (Subiendo mi proyecto terminado)

var app = builder.Build();

// Configurar el pipeline HTTP.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
}

<<<<<<< HEAD

=======
>>>>>>> 0fa103b (Subiendo mi proyecto terminado)
app.UseAntiforgery();

app.MapStaticAssets();
app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
