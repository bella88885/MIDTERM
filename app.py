from flask import Flask, render_template, send_from_directory, request,session
from flask_mysqldb import MySQL

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Gizli anahtar
# MySQL bağlantısı için ayarlar
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '123456'
app.config['MYSQL_DB'] = 'urunler'

mysql = MySQL(app)
@app.route('/')
def index():
    cur = mysql.connection.cursor()
    cur.execute("SELECT campaign_image_url FROM campaigns")
    campaign_images = cur.fetchall()

    # Kategorileri veritabanından çek
    cur.execute("SELECT kategori_name FROM kategori")
    categories = cur.fetchall()

    cur.close()

    return render_template('index.html', campaign_images=campaign_images, categories=categories)




@app.route('/search', methods=['GET', 'POST'])
def search():
    keyword = request.form.get('keyword', '')
    session['keyword'] = keyword
    category = request.args.get('category', '')
    session['category'] = category
    yarin_kapimda = request.form.get('yarin_kapimda')
    location = request.form.get('location')

    cur = mysql.connection.cursor()

    search_query = """
        SELECT products.product_no, products.product_name, products.description, 
               products.price, kategori.kategori_name, products.rating_num, products.marka , product_variants.color, 
               product_variants.image_url 
        FROM products 
        JOIN product_variants ON products.product_no = product_variants.product_no
        JOIN kategori ON products.category_id = kategori.category_id
        WHERE (products.product_name LIKE %s OR products.description LIKE %s OR kategori.kategori_name LIKE %s OR product_variants.color LIKE %s
       OR products.marka LIKE %s)
    """

    cur.execute(search_query, ('%' + keyword + '%', '%' + keyword + '%', '%' + keyword + '%', '%' + keyword + '%', '%' + keyword + '%'))
    search_results = cur.fetchall()

    filtered_results = []

    # Filtreleme işlemi
    for row in search_results:
        product_no = row[0]
        cur.execute("SELECT location, yarin_kapimda FROM filters WHERE product_no = %s", (product_no,))
        filters = cur.fetchall()
        for f in filters:
            if (not location or f[0] == location) and (not yarin_kapimda or f[1] == int(yarin_kapimda)):
                if not category or row[4] == category:
                    filtered_results.append(row)
                break

    # Her ürünün yalnızca bir kez görünmesini sağlamak için bir sözlük oluşturalım
    unique_products = {}
    for row in filtered_results:
        product_id = row[0]
        if product_id not in unique_products:
            unique_products[product_id] = row

    # Sözlüğü değerler listesine dönüştürelim
    unique_product_list = list(unique_products.values())

    product_variants = {}
    for row in unique_product_list:
        if row[0] not in product_variants:
            product_variants[row[0]] = []
        product_variants[row[0]].append(row[7:])  # Renk ve resim URL'si

    cur = mysql.connection.cursor()
    cur.execute("SELECT kategori_name FROM kategori")
    kategoriler = cur.fetchall()   
    cur.close()

    return render_template('search_results.html', search_results=unique_product_list, product_variants=product_variants, kategoriler=kategoriler, keyword=keyword)




def get_product_details(product_no):
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT product_name, description, price, kategori.kategori_name, rating_num, marka 
        FROM products 
        JOIN kategori ON products.category_id = kategori.category_id 
        WHERE product_no = %s
        """, (product_no,))
    product = cur.fetchone()
    cur.execute("SELECT color, image_url FROM product_variants WHERE product_no = %s", (product_no,))
    variants = cur.fetchall()
    cur.execute("SELECT satici, satici_puan FROM satici_info WHERE product_no = %s", (product_no,))
    seller_info = cur.fetchone()
    cur.close()
    return product, variants, seller_info


@app.route('/apply_filters', methods=['POST'])
def apply_filters():
    keyword = session.get('keyword', '')
    category = session.get('category', '')
    yarin_kapimda = request.form.get('yarin_kapimda')
    location = request.form.get('location')

    cur = mysql.connection.cursor()

    search_query = """
        SELECT products.product_no, products.product_name, products.description, 
               products.price, kategori.kategori_name, products.rating_num, products.marka , product_variants.color, 
               product_variants.image_url 
        FROM products 
        JOIN product_variants ON products.product_no = product_variants.product_no
        JOIN kategori ON products.category_id = kategori.category_id
        WHERE (products.product_name LIKE %s OR products.description LIKE %s OR kategori.kategori_name LIKE %s)
    """

    cur.execute(search_query, ('%' + keyword + '%', '%' + keyword + '%', '%' + keyword + '%'))
    search_results = cur.fetchall()

    filtered_results = []

    # Filtreleme işlemi
    for row in search_results:
        product_no = row[0]
        cur.execute("SELECT location, yarin_kapimda FROM filters WHERE product_no = %s", (product_no,))
        filters = cur.fetchall()
        for f in filters:
            if (not location or f[0] == location) and (not yarin_kapimda or f[1] == int(yarin_kapimda)):
                if not category or row[4] == category:
                    filtered_results.append(row)
                break

    # Her ürünün yalnızca bir kez görünmesini sağlamak için bir sözlük oluşturalım
    unique_products = {}
    for row in filtered_results:
        product_id = row[0]
        if product_id not in unique_products:
            unique_products[product_id] = row

    # Sözlüğü değerler listesine dönüştürelim
    unique_product_list = list(unique_products.values())

    product_variants = {}
    for row in unique_product_list:
        if row[0] not in product_variants:
            product_variants[row[0]] = []
        product_variants[row[0]].append(row[7:])  # Renk ve resim URL'si

    cur = mysql.connection.cursor()
    cur.execute("SELECT kategori_name FROM kategori")
    kategoriler = cur.fetchall()   
    cur.close()

    return render_template('search_results.html', search_results=unique_product_list, product_variants=product_variants, kategoriler=kategoriler, keyword=keyword)


@app.route('/product/<int:product_no>')
def show_product_details(product_no):
    product, variants, seller_info = get_product_details(product_no)
    return render_template('product_details.html', product=product, variants=variants, seller_info=seller_info)






@app.route('/images/<path:filename>')
def get_image(filename):
    return send_from_directory('images', filename)

if __name__ == "__main__":
    app.run(debug=True)