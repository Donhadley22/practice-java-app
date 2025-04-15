<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Peabsmart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #4b0082;
            color: white;
            padding: 20px;
            text-align: center;
        }
        nav {
            background-color: #333;
            overflow: hidden;
        }
        nav a {
            float: left;
            display: block;
            color: #f2f2f2;
            padding: 14px 16px;
            text-decoration: none;
        }
        nav a:hover {
            background-color: #575757;
        }
        .content {
            padding: 30px;
        }
        footer {
            text-align: center;
            background-color: #4b0082;
            color: white;
            padding: 15px;
            position: fixed;
            width: 100%;
            bottom: 0;
        }
        .logo {
            height: 150px;
            width: 150px;
            vertical-align: middle;
        }
    </style>
</head>
<body>

<header>
    <img src="images/peabsmart-logo.png" alt="Peabsmart Logo" class="logo">
    <h1>Welcome to Peabsmart</h1>
    <p>Cloud & DevOps | Software | Cybersecurity | IT Support</p>
</header>

<nav>
    <a href="index.jsp">Home</a>
    <a href="about.jsp">About</a>
    <a href="services.jsp">Services</a>
    <a href="contact.jsp">Contact</a>
    <a href="https://github.com/Donhadley22" target="_blank">GitHub</a>
    <a href="https://www.linkedin.com/in/bernard-uwaezuoke-29b33488/" target="_blank">LinkedIn</a>
    <a href="https://dev.to/donhadley22" target="_blank">Blog</a>
</nav>

<div class="content">
    <h2>🚀 Innovating the Future of IT</h2>
    <p>At Peabsmart, we deliver cutting-edge solutions in cloud computing, DevOps, secure software development, and smart IT support.</p>
    <p>Whether you're scaling infrastructure, building cloud-native applications, or modernizing operations — we’ve got you covered.</p>
    <p>🌐 Current date and time: <%= new java.util.Date() %></p>
</div>

<footer>
    &copy; Peabsmart Technologies, 2025. All rights reserved.
</footer>

</body>
</html>
