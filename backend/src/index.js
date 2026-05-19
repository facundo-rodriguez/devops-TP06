const express = require('express');
const mysql = require('mysql2');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

// Configuración de la conexión a Clever Cloud
const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT
});

db.connect(err => {
    if (err) {
        console.error('Error conectando a la DB:', err);
        return;
    }
    console.log('Conectado a la base de datos en Clever Cloud');
});

// Endpoints requeridos
app.get('/', (req, res) => res.json({ mensaje: "API Node.js para TP05" }));

app.get('/categories', (req, res) => {
    db.query('SELECT * FROM categorias', (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows);
    });
});

app.get('/products', (req, res) => {
    db.query('SELECT * FROM productos', (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows);
    });
});

// Endpoint de salud (Muy importante para el TP05/06)
app.get('/health', (req, res) => {
    res.json({ status: 'OK', uptime: process.uptime() });
});

app.listen(port, () => {
    console.log(`Servidor corriendo en http://localhost:${port}`);
});