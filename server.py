from flask import Flask, request, jsonify
import duckdb

app = Flask(__name__)

@app.route('/query', methods=['GET'])
def query():
    sql = request.args.get('sql')
    if not sql:
        return jsonify({"error": "Brak parametru sql"}), 400
    try:
        con = duckdb.connect('/db/formula1.db')
        result = con.execute(sql).fetchall()
        con.close()
        return jsonify({"results": result})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)