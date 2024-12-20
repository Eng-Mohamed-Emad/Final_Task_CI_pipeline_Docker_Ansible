@app.route('/plot')
def plot():
    try:
        # Ensure static directory exists
        if not os.path.exists('static'):
            os.makedirs('static')
        
        # Fetch data from the database
        with sqlite3.connect(DB_FILE) as conn:
            cursor = conn.cursor()
            cursor.execute('SELECT city, temperature FROM weather')
            data = cursor.fetchall()

        if not data:
            return "No data available to plot.", 400

        cities = [row[0] for row in data]
        temperatures = [row[1] for row in data]

        # Generate the plot
        plt.figure(figsize=(10, 6))
        plt.bar(cities, temperatures, color='skyblue')
        plt.title('City Temperatures')
        plt.xlabel('City')
        plt.ylabel('Temperature (°C)')
        plot_path = os.path.join('static', 'plot.png')
        plt.savefig(plot_path)  # Save as plot.png
        plt.close()

        return send_file(plot_path, mimetype='image/png')  # Serve the file
    except Exception as e:
        return f"An error occurred: {e}", 500
