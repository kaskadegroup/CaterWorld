import os
from flask import Flask, request, jsonify, render_template
from firebase_admin import credentials, firestore, initialize_app

app = Flask(__name__)
print(os.path.dirname(os.path.abspath(__file__)))
cred = credentials.Certificate('../../../secret/tostea/key.json')
defualt_app = initialize_app(cred)
db = firestore.client()
dishes_ref = db.collection('dishInfo')

@app.route('/dishes/all_dishes', methods=['GET'])
def dishes():
    dishes = [doc.to_dict() for doc in dishes_ref.stream()]
    print(dishes[0])
    return render_template('dishes.html', dishes=dishes)


@app.route('/dishes/<dish_id>')
def get_dish(dish_id):
    dish = dishes_ref.document(dish_id).get()
    return jsonify(dish.to_dict()), 200


port = int(os.environ.get('PORT', 8080))
if __name__ == '__main__':

    app.run(threaded=True, host='0.0.0.0', port=port)
