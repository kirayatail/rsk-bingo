const express = require('express');
const app = express();
const fs = require('fs');
const lodash = require('lodash');

app.use(express.static('public'));

const allHeaders = fs.readFileSync('headers.txt', 'utf8').split('\n');

function makeBoard() {
  const allTiles = fs.readFileSync('tiles.txt', 'utf8').split('\n');
  const freeTiles = fs.readFileSync('freetiles.txt', 'utf8').split('\n');
  const board = lodash.take(lodash.shuffle(allTiles), 24).map((t, i) => {
    return {
      text: t,
      index: i,
      checked: false
    }
  });
  board.splice(12, 0, {
    text: lodash.shuffle(freeTiles)[0],
    index: 25,
    checked: true
  });
  return board
}

function makeHeader() {
  return lodash.shuffle(allHeaders)[0];
}

app.get('/', (req, res) => {
  return res.sendFile('index.html');
})

app.get('/content', (req, res) =>{
  return res.status(200).send({
    board: makeBoard(),
    header: makeHeader()
  })
})

let p;
app.listen(p = (process.env.PORT || 3001), () => {
  console.log('App running on port '+p);
})