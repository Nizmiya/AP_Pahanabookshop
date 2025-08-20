<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pahana - Your Favorite Online Bookstore</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                scroll-behavior: smooth;
            }

            /* Navigation Styles */
            .navbar {
                background: linear-gradient(135deg, #276221 0%, #1f4d1a 100%);
                padding: 1rem 0;
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 1000;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .navbar-brand {
                font-size: 1.8rem;
                font-weight: 700;
                color: #ffd700 !important;
                text-decoration: none;
            }

            .navbar-nav .nav-link {
                color: white !important;
                font-weight: 500;
                margin: 0 0.5rem;
                padding: 0.5rem 1rem;
                border-radius: 6px;
                transition: all 0.3s ease;
            }

            .navbar-nav .nav-link:hover {
                background-color: rgba(255,255,255,0.1);
                color: #ffd700 !important;
                transform: translateY(-2px);
            }

            .navbar-nav .nav-link.active {
                background-color: rgba(255,255,255,0.2);
                color: #ffd700 !important;
            }

            .btn-login {
                background: rgba(255, 255, 255, 0.3);
                border: 1px solid rgba(255, 255, 255, 0.5);
                color: white;
                padding: 0.5rem 1.5rem;
                border-radius: 25px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-login:hover {
                transform: translateY(-2px);
                background: rgba(255, 255, 255, 0.5);
                box-shadow: 0 4px 15px rgba(255, 255, 255, 0.3);
                color: white;
            }

            /* Hero Section */
            .hero-section {
                background: linear-gradient(135deg, #5bb450 0%, #4a9a3f 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                padding-top: 80px;
                position: relative;
                overflow: hidden;
            }

            .hero-content {
                color: white;
                z-index: 2;
                position: relative;
            }

            .hero-title {
                font-size: 3.5rem;
                font-weight: 700;
                margin-bottom: 1.5rem;
                line-height: 1.2;
            }

            .hero-subtitle {
                font-size: 1.2rem;
                margin-bottom: 2rem;
                opacity: 0.9;
                line-height: 1.6;
            }

            .btn-read-more {
                background: rgba(255,255,255,0.2);
                border: 2px solid rgba(255,255,255,0.3);
                color: white;
                padding: 1rem 2rem;
                border-radius: 30px;
                font-weight: 600;
                font-size: 1.1rem;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
            }

            .btn-read-more:hover {
                background: rgba(255,255,255,0.3);
                border-color: rgba(255,255,255,0.5);
                color: white;
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.2);
            }


            .hero-illustrations {
                position: relative;
                height: 100%;
            }

            .illustration {
                position: absolute;
                opacity: 0.8;
            }

            .illustration-1 {
                top: 20%;
                left: 10%;
                transform: rotate(-15deg);
            }

            .illustration-2 {
                top: 60%;
                right: 15%;
                transform: rotate(10deg);
            }

            .illustration-3 {
                bottom: 20%;
                left: 20%;
                transform: rotate(-5deg);
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-10px);
                }
            }



            /* Section Styles */
            .section {
                padding: 5rem 0;
                min-height: 100vh;
                display: flex;
                align-items: center;
            }

            .section-title {
                font-size: 3rem;
                font-weight: 700;
                margin-bottom: 2rem;
                text-align: center;
                color: #2c3e50;
            }

            .section-subtitle {
                font-size: 1.2rem;
                color: #6c757d;
                text-align: center;
                margin-bottom: 3rem;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }

            /* About Section */
            .about-section {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            }

            .about-card {
                background: white;
                border-radius: 15px;
                padding: 2rem;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                height: 100%;
                transition: all 0.3s ease;
            }

            .about-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            }

            .about-icon {
                font-size: 3rem;
                color: #90EE90;
                margin-bottom: 1rem;
            }

            /* Services Section */
            .services-section {
                background: white;
            }

            .service-card {
                background: linear-gradient(135deg, #52a447 0%, #4a8f3f 100%);
                color: white;
                border-radius: 15px;
                padding: 2rem;
                text-align: center;
                height: 100%;
                transition: all 0.3s ease;
            }

            .service-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 40px rgba(82, 164, 71, 0.3);
            }

            .service-icon {
                font-size: 3rem;
                margin-bottom: 1rem;
                opacity: 0.9;
            }

            /* Categories Section */
            .categories-section {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            }

            .category-card {
                background: white;
                border-radius: 10px;
                padding: 0.75rem;
                box-shadow: 0 3px 12px rgba(0,0,0,0.05);
                height: 100%;
                transition: all 0.3s ease;
                text-align: center;
                position: relative;
                overflow: hidden;
                cursor: pointer;
            }

            .category-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(135deg, #5bb450 0%, #4a9a3f 100%);
            }

            .category-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 20px 40px rgba(91, 180, 80, 0.2);
            }

            .category-icon {
                margin-bottom: 1.5rem;
            }

            .category-icon i {
                font-size: 2rem;
                color: #5bb450;
                background: linear-gradient(135deg, #f0f8f0 0%, #e8f5e8 100%);
                width: 60px;
                height: 60px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto;
                border: 2px solid #5bb450;
                transition: all 0.3s ease;
            }

            .category-card:hover .category-icon i {
                transform: scale(1.1);
                background: linear-gradient(135deg, #5bb450 0%, #4a9a3f 100%);
                color: white;
            }

            .category-info h4 {
                color: #333;
                font-weight: 700;
                margin-bottom: 0.3rem;
                font-size: 0.9rem;
            }

            .category-count {
                color: #5bb450;
                font-weight: 600;
                font-size: 0.75rem;
                margin-bottom: 0.5rem;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .category-description {
                color: #666;
                font-size: 0.7rem;
                line-height: 1.2;
                margin-bottom: 0.5rem;
            }

            .category-features {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
                justify-content: center;
            }

            .feature-tag {
                background: linear-gradient(135deg, #5bb450 0%, #4a9a3f 100%);
                color: white;
                padding: 0.2rem 0.5rem;
                border-radius: 10px;
                font-size: 0.65rem;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .feature-tag:hover {
                transform: scale(1.05);
                box-shadow: 0 4px 10px rgba(91, 180, 80, 0.3);
            }

            /* Contact Section */
            .contact-section {
                background: linear-gradient(135deg, #cce7c9 0%, #b8d9b5 100%);
                color: #333;
            }

            .bookshop-details {
                background: rgba(255,255,255,0.2);
                border-radius: 15px;
                padding: 1rem 1rem;
                backdrop-filter: blur(10px);
                height: 100%;
                min-height: 350px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.06);
            }

            .contact-info {
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
            }

            .contact-item {
                display: flex;
                align-items: flex-start;
                gap: 1rem;
                padding: 1rem;
                background: rgba(255,255,255,0.1);
                border-radius: 15px;
                transition: all 0.3s ease;
                margin-bottom: 0.5rem;
            }

            .contact-item:hover {
                background: rgba(255,255,255,0.2);
                transform: translateX(5px);
            }

            .contact-item-simple {
                display: flex;
                align-items: flex-start;
                gap: 0.5rem;
                padding: 0.25rem 0;
                transition: all 0.3s ease;
                margin-bottom: 0.5rem;
                border-bottom: 1px solid rgba(255,255,255,0.1);
            }

            .contact-item-simple:last-child {
                border-bottom: none;
            }

            .contact-item-simple:hover {
                transform: translateX(5px);
            }

            .contact-icon {
                background: linear-gradient(135deg, #5bb450, #4a9a3f);
                color: white;
                width: 35px;
                height: 35px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.9rem;
                flex-shrink: 0;
                box-shadow: 0 3px 10px rgba(91, 180, 80, 0.2);
            }

            .contact-text h5 {
                color: #2c3e50;
                font-weight: 700;
                margin-bottom: 0.15rem;
                font-size: 0.9rem;
            }

            .contact-text p {
                color: #2c3e50;
                margin-bottom: 0.05rem;
                font-size: 0.8rem;
                opacity: 0.9;
                line-height: 1.2;
            }

            .contact-form {
                background: rgba(255,255,255,0.2);
                border-radius: 15px;
                padding: 1rem 1rem;
                backdrop-filter: blur(10px);
                min-height: 350px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.06);
            }

            .form-control {
                background: rgba(255,255,255,0.3);
                border: 1px solid rgba(255,255,255,0.4);
                color: #333;
                border-radius: 8px;
                padding: 0.75rem;
            }

            .form-control:focus {
                background: rgba(255,255,255,0.4);
                border-color: rgba(255,255,255,0.6);
                color: #333;
                box-shadow: 0 0 0 0.2rem rgba(255,255,255,0.3);
            }

            .form-control::placeholder {
                color: rgba(51, 51, 51, 0.7);
            }

            .btn-submit {
                background: linear-gradient(135deg, #276221 0%, #1f4d1a 100%);
                border: none;
                color: white;
                padding: 0.75rem 2rem;
                border-radius: 25px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(39, 98, 33, 0.4);
                color: white;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .hero-title {
                    font-size: 2.5rem;
                }
                
                .section-title {
                    font-size: 2.5rem;
                }
                
                .hero-illustrations {
                    display: none;
                }
                
                .bookshop-details,
                .contact-form {
                    min-height: auto;
                    padding: 2rem 1.5rem;
                    margin-bottom: 2rem;
                }
                
                .contact-item {
                    padding: 1rem;
                    gap: 1rem;
                }
                
                .contact-icon {
                    width: 50px;
                    height: 50px;
                    font-size: 1.2rem;
                }
            }

            /* Smooth scrolling for anchor links */
            html {
                scroll-behavior: smooth;
            }
        </style>
    </head>
    <body>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand" href="#home">
                    <i class="bi bi-book"></i> Pahana
                </a>
                
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="#home">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about">About</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#categories">Categories</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#services">Services</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#contact">Contact</a>
                        </li>
                    </ul>
                    <a href="login.jsp" class="btn btn-login">
                        <i class="bi bi-person-circle me-2"></i>Login
                    </a>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <section id="home" class="hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <div class="hero-content">
                            <h1 class="hero-title">YOUR FAVORITE ONLINE BOOKSTORE</h1>
                            <p class="hero-subtitle">
                                Discover a world of knowledge with our extensive collection of books. 
                                From bestsellers to academic texts, we have everything you need to 
                                fuel your imagination and expand your horizons.
                            </p>
                            <a href="#about" class="btn-read-more">READ MORE</a>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="hero-illustrations">
                            <div class="illustration illustration-1">
                                <i class="bi bi-phone" style="font-size: 4rem; color: rgba(255,255,255,0.3);"></i>
                            </div>
                            <div class="illustration illustration-2">
                                <i class="bi bi-cup-hot" style="font-size: 3rem; color: rgba(255,255,255,0.3);"></i>
                            </div>
                            <div class="illustration illustration-3">
                                <i class="bi bi-collection" style="font-size: 5rem; color: rgba(255,255,255,0.3);"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- About Section -->
        <section id="about" class="section about-section">
            <div class="container">
                <h2 class="section-title">About BookShop</h2>
                <p class="section-subtitle">
                    We are passionate about bringing the best books to our readers. 
                    Our mission is to make knowledge accessible to everyone.
                </p>
                
                <div class="row g-4">
                    <div class="col-lg-4">
                        <div class="about-card">
                            <div class="about-icon">
                                <i class="bi bi-book"></i>
                            </div>
                            <h4>Extensive Collection</h4>
                            <p>Browse through thousands of books across all genres and categories. From fiction to non-fiction, we have it all.</p>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="about-card">
                            <div class="about-icon">
                                <i class="bi bi-truck"></i>
                            </div>
                            <h4>Fast Delivery</h4>
                            <p>Get your books delivered to your doorstep with our reliable and fast delivery service.</p>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="about-card">
                            <div class="about-icon">
                                <i class="bi bi-shield-check"></i>
                            </div>
                            <h4>Secure Shopping</h4>
                            <p>Shop with confidence knowing your information is protected with the latest security measures.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Categories Section -->
        <section id="categories" class="section categories-section">
            <div class="container">
                <h2 class="section-title">Famous Categories</h2>
                <p class="section-subtitle">
                    Explore our extensive collection of books across various categories. 
                    From fiction to academic, find your perfect read.
                </p>
                
                <div class="row g-2" style="margin-bottom: 1rem;">
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="category-icon">
                                <i class="bi bi-book"></i>
                            </div>
                            <div class="category-info">
                                <h4>Fiction</h4>
                                <p class="category-count">1000+ Books</p>
                                <p class="category-description">Novels, short stories, and creative literature.</p>
                                <div class="category-features">
                                    <span class="feature-tag">Novels</span>
                                    <span class="feature-tag">Stories</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="category-icon">
                                <i class="bi bi-mortarboard"></i>
                            </div>
                            <div class="category-info">
                                <h4>Academic</h4>
                                <p class="category-count">500+ Books</p>
                                <p class="category-description">Textbooks and reference materials.</p>
                                <div class="category-features">
                                    <span class="feature-tag">Textbooks</span>
                                    <span class="feature-tag">Reference</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="category-icon">
                                <i class="bi bi-stars"></i>
                            </div>
                            <div class="category-info">
                                <h4>Fantasy & Sci-Fi</h4>
                                <p class="category-count">800+ Books</p>
                                <p class="category-description">Magical and futuristic worlds.</p>
                                <div class="category-features">
                                    <span class="feature-tag">Fantasy</span>
                                    <span class="feature-tag">Sci-Fi</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="category-icon">
                                <i class="bi bi-code-slash"></i>
                            </div>
                            <div class="category-info">
                                <h4>Technology</h4>
                                <p class="category-count">400+ Books</p>
                                <p class="category-description">Programming and tech guides.</p>
                                <div class="category-features">
                                    <span class="feature-tag">Programming</span>
                                    <span class="feature-tag">Tech</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row g-2" style="margin-top: 1rem;">
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="category-icon">
                                <i class="bi bi-search"></i>
                            </div>
                            <div class="category-info">
                                <h4>Mystery & Thriller</h4>
                                <p class="category-count">700+ Books</p>
                                <p class="category-description">Suspenseful detective stories.</p>
                                <div class="category-features">
                                    <span class="feature-tag">Mystery</span>
                                    <span class="feature-tag">Thriller</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="category-icon">
                                <i class="bi bi-lightbulb"></i>
                            </div>
                            <div class="category-info">
                                <h4>Self-Help</h4>
                                <p class="category-count">400+ Books</p>
                                <p class="category-description">Personal growth and motivation.</p>
                                <div class="category-features">
                                    <span class="feature-tag">Growth</span>
                                    <span class="feature-tag">Success</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="category-icon">
                                <i class="bi bi-globe"></i>
                            </div>
                            <div class="category-info">
                                <h4>Travel & Adventure</h4>
                                <p class="category-count">300+ Books</p>
                                <p class="category-description">Travel guides and adventures.</p>
                                <div class="category-features">
                                    <span class="feature-tag">Travel</span>
                                    <span class="feature-tag">Adventure</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="category-icon">
                                <i class="bi bi-cup-hot"></i>
                            </div>
                            <div class="category-info">
                                <h4>Biography & History</h4>
                                <p class="category-count">500+ Books</p>
                                <p class="category-description">Real stories and history.</p>
                                <div class="category-features">
                                    <span class="feature-tag">Biography</span>
                                    <span class="feature-tag">History</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Services Section -->
        <section id="services" class="section services-section">
            <div class="container">
                <h2 class="section-title">Our Services</h2>
                <p class="section-subtitle">
                    We offer a comprehensive range of services to meet all your reading needs.
                </p>
                
                <div class="row g-4">
                    <div class="col-lg-3 col-md-6">
                        <div class="service-card">
                            <div class="service-icon">
                                <i class="bi bi-search"></i>
                            </div>
                            <h5>Book Search</h5>
                            <p>Find exactly what you're looking for with our advanced search and filtering options.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="service-card">
                            <div class="service-icon">
                                <i class="bi bi-heart"></i>
                            </div>
                            <h5>Wishlist</h5>
                            <p>Save your favorite books and get notified when they're back in stock.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="service-card">
                            <div class="service-icon">
                                <i class="bi bi-star"></i>
                            </div>
                            <h5>Reviews</h5>
                            <p>Read and write reviews to help other readers make informed decisions.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="service-card">
                            <div class="service-icon">
                                <i class="bi bi-headset"></i>
                            </div>
                            <h5>24/7 Support</h5>
                            <p>Get help anytime with our round-the-clock customer support service.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Contact Section -->
        <section id="contact" class="section contact-section">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <h2 class="section-title">Contact Us</h2>
                        <p class="section-subtitle">
                            Have questions? We'd love to hear from you. Send us a message and we'll respond as soon as possible.
                        </p>
                    </div>
                </div>
                
                <div class="row justify-content-center">
                    <!-- Bookshop Details - Left Side -->
                    <div class="col-lg-5 col-xl-4">
                        <div class="bookshop-details">
                            <h3 style="color: #2c3e50; font-weight: 700; margin-bottom: 1rem; text-align: center; font-size: 1.3rem;">
                                <i class="bi bi-shop me-2" style="color: #5bb450;"></i>Pahana Edu BookShop
                            </h3>
                            
                            <div class="contact-info">
                                <div class="contact-item-simple">
                                    <div class="contact-icon">
                                        <i class="bi bi-geo-alt-fill"></i>
                                    </div>
                                    <div class="contact-text">
                                        <h5>Address</h5>
                                        <p>Sri Lanka, Colombo</p>
                                    </div>
                                </div>
                                
                                <div class="contact-item-simple">
                                    <div class="contact-icon">
                                        <i class="bi bi-telephone-fill"></i>
                                    </div>
                                    <div class="contact-text">
                                        <h5>Phone Numbers</h5>
                                        <p>+94 11 234 5678</p>
                                        <p>+94 77 123 4567</p>
                                        <p>+94 76 987 6543</p>
                                    </div>
                                </div>
                                
                                <div class="contact-item-simple">
                                    <div class="contact-icon">
                                        <i class="bi bi-envelope-fill"></i>
                                    </div>
                                    <div class="contact-text">
                                        <h5>Email</h5>
                                        <p>info@pahanaedubookshop.com</p>
                                        <p>support@pahanaedubookshop.com</p>
                                    </div>
                                </div>
                                
                                <div class="contact-item-simple">
                                    <div class="contact-icon">
                                        <i class="bi bi-clock-fill"></i>
                                    </div>
                                    <div class="contact-text">
                                        <h5>Business Hours</h5>
                                        <p>Monday - Friday: 9:00 AM - 8:00 PM</p>
                                        <p>Saturday: 9:00 AM - 6:00 PM</p>
                                        <p>Sunday: 10:00 AM - 4:00 PM</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Contact Form - Right Side -->
                    <div class="col-lg-5 col-xl-6">
                        <div class="contact-form">
                            <h3 style="color: #2c3e50; font-weight: 700; margin-bottom: 1rem; text-align: center; font-size: 1.3rem;">
                                <i class="bi bi-chat-dots me-2" style="color: #5bb450;"></i>Send us a Message
                            </h3>
                            <form>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" placeholder="Your Name" required>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="email" class="form-control" placeholder="Your Email" required>
                                    </div>
                                    <div class="col-12">
                                        <input type="text" class="form-control" placeholder="Subject" required>
                                    </div>
                                    <div class="col-12">
                                        <textarea class="form-control" rows="3" placeholder="Your Message" required></textarea>
                                    </div>
                                    <div class="col-12 text-center">
                                        <button type="submit" class="btn btn-submit">
                                            <i class="bi bi-send me-2"></i>Send Message
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-dark text-white text-center py-4">
            <div class="container">
                <p class="mb-0">&copy; 2025 Pahana. All rights reserved. | Pahana Edu BookShop</p>
            </div>
        </footer>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
            // Smooth scrolling for navigation links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });

            // Active navigation highlighting
            window.addEventListener('scroll', () => {
                const sections = document.querySelectorAll('section[id]');
                const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
                
                let current = '';
                sections.forEach(section => {
                    const sectionTop = section.offsetTop;
                    const sectionHeight = section.clientHeight;
                    if (scrollY >= (sectionTop - 200)) {
                        current = section.getAttribute('id');
                    }
                });

                navLinks.forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') === '#' + current) {
                        link.classList.add('active');
                    }
                });
            });

            // Form submission handling
            document.querySelector('form').addEventListener('submit', function(e) {
                e.preventDefault();
                alert('Thank you for your message! We will get back to you soon.');
                this.reset();
            });
        </script>
    </body>
</html>
