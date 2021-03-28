import os
from flask import Flask, request, jsonify, render_template, redirect, url_for, Response
from firebase_admin import credentials, firestore, initialize_app

app = Flask(__name__)
cred = credentials.Certificate('../../../secret/tostea/key.json')
defualt_app = initialize_app(cred)
db = firestore.client()
dishes_ref = db.collection('dishInfo')


@app.route('/dishes/all_dishes', methods=['GET', 'POST'])
def dishes():
    dishes = [doc.to_dict() for doc in dishes_ref.where("status", '==', 'PENDING').stream()]
    return render_template('all_dishes.html', dishes=dishes)


@app.route('/dishes/<dish_id>', methods=['GET', 'POST'])
def get_dish(dish_id):

    dish = dishes_ref.document(dish_id).get().to_dict()

    return render_template('dish.html', dish=dish)


@app.route('/update', methods=['POST', 'PUT'])
def update():
    try:
        id = request.form['id']
        dishes_ref.document(id).update({'status':'APPROVED'})
        return redirect(url_for('dishes'))
    except Exception as e:
        return f"An Error Occured: {e}"


port = int(os.environ.get('PORT', 8080))
if __name__ == '__main__':

    app.run(threaded=True, host='0.0.0.0', port=port, debug=True)
