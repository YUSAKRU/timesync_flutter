// TimeSync - Tailwind CSS Configuration
tailwind.config = {
    darkMode: "class",
    theme: {
        extend: {
            colors: {
                "primary": "#36e27b",
                "primary-dark": "#2ab561",
                "background-light": "#f6f8f7",
                "background-dark": "#112117",
                "surface-dark": "#1b3224",
                "surface-light": "#ffffff",
                "text-secondary": "#95c6a9",
                "accent-orange": "#FF8A65",
                "accent-purple": "#BA68C8",
            },
            fontFamily: {
                "display": ["Spline Sans", "Plus Jakarta Sans", "Inter", "Manrope", "sans-serif"]
            },
            borderRadius: {
                "DEFAULT": "1rem", 
                "lg": "1.5rem", 
                "xl": "2rem", 
                "2xl": "2.5rem",
                "3xl": "3rem", 
                "full": "9999px"
            },
            backgroundImage: {
                'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
            },
            boxShadow: {
                'soft': '0 4px 20px -2px rgba(0, 0, 0, 0.05)',
                'glow': '0 0 20px rgba(13, 242, 166, 0.15)',
            }
        },
    },
}
