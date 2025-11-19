$<?php

$host = "192.168.56.11";
$user = "tp_user";
$pass = "tp_password";
$db   = "tp_db";

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    echo "<h1>Connexion MariaDB réussie !</h1>";
    echo "<p>La Base de données est : $db</p>";

 } catch (PDOException $e) {
    echo "<h1>Erreur connexion MariaDB :</h1>";
    echo "<p>" . $e->getMessage() . "</p>";
}

?>





