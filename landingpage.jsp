<%-- 
    Document   : landingpage
    Created on : 19 May 2025, 12:31:38?pm
    Author     : Msft
--%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>EazyEats</title>

  <!-- Embedded CSS -->
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background: #fff;
      color: #f3c6c6;
     background-image: url('Images/l5.jpeg');
 /* Make sure l5.jpeg is in the same folder or inside /images */
      background-size: cover;
      background-position: center;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    header {
      box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.5);
      padding: 20px 40px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      color: white;
      background: rgba(23, 22, 22, 0.95);
    }

    header h1 {
      font-size: 28px;
    }

    nav a {
      color: rgb(240, 229, 229);
      margin-left: 20px;
      text-decoration: none;
      font-weight: 600;
    }

    nav a:hover {
      text-decoration: underline;
      color: white;
    }

    .hero {
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      align-items: center;
      padding: 60px 40px;
      min-height: 100vh;
    }

    .hero-text {
      max-width: 50%;
    }

    .hero-text h2 {
      font-size: 48px;
      color: #fccf3b;
      margin-bottom: 20px;
    }

    .hero-text p {
      font-size: 18px;
      margin-bottom: 30px;
      color: #fff;
    }

    .hero-text button {
      background: rgb(234, 24, 24);
      border: none;
      color: white;
      padding: 12px 24px;
      font-size: 16px;
      cursor: pointer;
      border-radius: 8px;
    }

    .hero-image img {
      width: 450px;
      border-radius: 12px;
    }

    footer {
      background: rgba(39, 37, 37, 0.95);
      color: white;
      padding: 40px 20px;
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 20px;
      margin-top: auto;
      font-size: 14px;
      box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.5);
    }

    .footer-links,
    .footer-contact,
    .footer-social {
      display: flex;
      flex-direction: row;
      gap: 20px;
      flex-wrap: wrap;
      justify-content: center;
    }

    .footer-links a,
    .footer-social a {
      color: white;
      text-decoration: none;
    }

    .footer-social a i {
      font-size: 18px;
    }

    .footer-bottom {
      text-align: center;
      margin-top: 20px;
      border-top: 1px solid #fff5f5;
      padding-top: 10px;
    }

    .about-section {
      padding: 60px 20px;
      background-color: #202025;
      text-align: center;
      position: relative;
      z-index: 2;
    }

    .about-section h2 {
      font-size: 2rem;
      margin-bottom: 20px;
      color: #e5a716;
    }

    .about-section p {
      font-size: 1rem;
      line-height: 1.6;
      max-width: 800px;
      margin: 0 auto 15px;
      color: #f6eded;
    }
  </style>

  <!-- Fonts & Icons -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
</head>

<body>
  <header>
    <h1>EazyEats</h1>
    <nav>
      <a href="#">Home</a>
      <a href="detail.html">Menu</a>
      <a href="about.html">About</a>
      <a href="#foot">Contact</a>
      <a href="login.jsp">Login</a>
      <a href="register.jsp">Sign Up</a>
    </nav>
  </header>

  <section class="hero">
    <div class="hero-text">
      <h2>Welcome to EazyEats</h2>
      <p>A Canteen At Your Fingertip</p>
      <p>Get your favorite meals hot and fresh without any delay. Fast, affordable, and reliable service, every time.</p>
      <button onclick="window.location.href='detail.html'">Order Now</button>
    </div>
  </section>

  <footer id="foot">
    <div class="footer-links">
      <a href="#">Privacy Policy</a>
      <a href="#">Terms of Service</a>
      <a href="#">Help Center</a>
      <a href="#">FAQs</a>
    </div>
    <div class="footer-contact">
      <span>Email: support@eazyeats.com</span>
      <span>Phone: +1 (800) 123-4567</span>
    </div>
    <div class="footer-social">
      <a href="#"><i class="fab fa-facebook-f"></i></a>
      <a href="#"><i class="fab fa-instagram"></i></a>
      <a href="#"><i class="fab fa-twitter"></i></a>
    </div>
    <div class="footer-bottom">
      &copy; 2025 EazyEats. All rights reserved.
    </div>
  </footer>
</body>
</html>
