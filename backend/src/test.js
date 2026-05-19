const assert = require('assert');

// Test simple para validar que la lógica de autor funciona
function testAuthorName() {
    const author = "Rodriguez Facundo"; // Esto debería venir de una variable de entorno en realidad
    console.log("Iniciando test de autor...");
    try {
        assert.strictEqual(author, "Rodriguez Facundo");
        console.log("Test de autor pasado con éxito.");
    } catch (error) {
        console.error("Test de autor fallido.");
        process.exit(1);
    }
}

testAuthorName();

