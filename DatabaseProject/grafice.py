import matplotlib.pyplot as plt

def show_graphic_1(artist, num_caseta, num_cd, num_vinyl):
    # Plotting a bar chart
    labels = ['Numar Titluri Casete', 'Numar Titluri CD', 'Numar Titluri Vinyl']
    values = [num_caseta, num_cd, num_vinyl]

    plt.bar(labels, values, color=['blue', 'green', 'orange'])
    plt.xlabel('Formate Audio')
    plt.ylabel('Numar')
    plt.title(f'Disponibilitate Audio pentru Artistul: {artist}')
    plt.show()

def show_graphic_2(data):
    # Separate the data into lists for each column
    labels = ['CDID', 'TITLUCD', 'GEN', 'ARTISTID_FK8', 'AUDIOID_FK8']

    # Extract genre column
    genre_values = [row[labels.index('GEN')] for row in data]

    # Count occurrences of each genre
    genre_counts = {genre: genre_values.count(genre) for genre in set(genre_values)}

    # Plotting a bar chart
    plt.bar(genre_counts.keys(), genre_counts.values(), color=['blue', 'green', 'orange', 'red'])
    plt.xlabel('Genuri')
    plt.ylabel('Numar')
    plt.title('Genuri albume la acelasi pret')
    plt.show()

def show_graphic_3(data):
    # Separate the data into lists for each column
    labels = ['PRODUSID', 'DENUMIREPRODUS', 'PRET', 'STOC']

    # Extract name and price columns
    names = [row[labels.index('DENUMIREPRODUS')] for row in data]
    prices = [row[labels.index('PRET')] for row in data]

    # Plotting a bar chart
    plt.bar(names, prices, color=['blue', 'green', 'orange', 'red'])
    plt.xlabel('Denumire chitari')
    plt.ylabel('Pret')
    plt.title('Preturi pentru chitari cu acelasi material')
    plt.xticks(rotation=45, ha='right')  # Rotate x-axis labels for better visibility
    plt.show()



    