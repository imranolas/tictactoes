$(document).ready(function() {
var snakeApp = snakeApp || {};
var run;
snakeApp.curr_direction = "right";
snakeApp.direction = "right";
snakeApp.length = 5;
snakeApp.cellWidth = 15;
snakeApp.score = 0;
snakeApp.canvas, snakeApp.ctx, snakeApp.gameWidth, snakeApp.gameHeight, snakeApp.food, snakeApp.snake, snakeApp.state;


// .snake contains an array of objects. Each snake body cell is an array object with a x, y coordinate.

snakeApp.newSnake = function() {
  var arr = [];
  for (var i = snakeApp.length-1; i >= 0; i--) {
    arr.push({x: i, y: 0})
  }
  snakeApp.snake = arr;
};

snakeApp.snakeMove = function() {
  
  var nextHead = {};
  nextHead.x = snakeApp.snake[0].x;
  nextHead.y = snakeApp.snake[0].y;

  if(snakeApp.direction == "right") nextHead.x = (nextHead.x+1) % snakeApp.gameWidth;
  else if(snakeApp.direction == "left") { if (nextHead.x-- <= 0) nextHead.x = snakeApp.gameWidth - 1 ;}
  else if(snakeApp.direction == "up") { if (nextHead.y-- <= 0) nextHead.y = snakeApp.gameHeight - 1 ;}
  else if(snakeApp.direction == "down") nextHead.y = (nextHead.y+1) % snakeApp.gameHeight;
  snakeApp.checkForCollision(nextHead);
  if (snakeApp.hasEatenFood(nextHead)) {
    snakeApp.updateScore();
    snakeApp.makeFood();
  } else {
  snakeApp.snake.pop();
  }
  snakeApp.snake.unshift(nextHead);
  snakeApp.curr_direction = snakeApp.direction

};

snakeApp.draw = function () {
  snakeApp.ctx.clearRect(0, 0, snakeApp.canvas.width, snakeApp.canvas.height);

  $(snakeApp.snake).each(function(i,cell) {
    snakeApp.paintCell(cell.x * snakeApp.cellWidth, cell.y * snakeApp.cellWidth);
  })

  snakeApp.paintCell(snakeApp.food.x * snakeApp.cellWidth, snakeApp.food.y * snakeApp.cellWidth, "#699C9E");
};

snakeApp.paintCell = function(x, y, color) {
  if (color) {
  snakeApp.ctx.fillStyle = color;
} else {
    snakeApp.ctx.fillStyle = '#333';
}
  snakeApp.ctx.fillRect(x, y, snakeApp.cellWidth, snakeApp.cellWidth);
  snakeApp.ctx.strokeStyle = '#eee';
  snakeApp.ctx.strokeRect(x, y, snakeApp.cellWidth, snakeApp.cellWidth);
}

snakeApp.gameLoop = function() {
  if (!snakeApp.food) snakeApp.makeFood();
  snakeApp.draw();
  snakeApp.snakeMove();
}

snakeApp.checkForCollision = function(head) {
  $(snakeApp.snake).each(function(i,cell) {
    if (head.x == cell.x && head.y == cell.y) {
    snakeApp.state = 'gameover';
    clearInterval(run);
    
    $.ajax({
      url: '/snakes/create',
      dataType: 'json',
      type: 'post',
      data: {score: snakeApp.score},
      success: function(data) {
        $('#high_score').text(data.score)
      }
    })

    snakeApp.ctx.font = "bold 60px 'Press Start 2P'";
    snakeApp.ctx.textAlign = "center";
    snakeApp.ctx.textBaseline = 'middle';
    snakeApp.ctx.fillText("GAME OVER", 480, 200);
   }
  });
};

snakeApp.hasEatenFood = function(head) {
  return snakeApp.food.x == head.x && snakeApp.food.y == head.y;s
};

snakeApp.makeFood = function() {
  snakeApp.food = {
    x: Math.round(Math.random()*(snakeApp.gameWidth-1) ), 
    y: Math.round(Math.random()*(snakeApp.gameHeight-1) ), 
  };
};

snakeApp.updateScore = function() {
  snakeApp.score += 10;
  $('#current_score').text(snakeApp.score);
};

snakeApp.reset = function() {
    snakeApp.direction = "right";
    snakeApp.newSnake();
    snakeApp.score = -10;
    snakeApp.updateScore();
    snakeApp.ctx.clearRect(0, 0, snakeApp.canvas.width, snakeApp.canvas.height);
    snakeApp.ctx.font = "bold 20px 'Press Start 2P'";
    snakeApp.ctx.textAlign = "center";
    snakeApp.ctx.textBaseline = 'middle';
    snakeApp.ctx.fillText("Press SPACE to start.", 480, 200);
    snakeApp.state = 'welcome';
};

snakeApp.play = function() {
  snakeApp.state = 'playing';
  run = setInterval(snakeApp.gameLoop, 1000 / 15);
};

snakeApp.canvas = $('#canvas')[0];
if (snakeApp.canvas) {
snakeApp.ctx = snakeApp.canvas.getContext('2d');
snakeApp.gameWidth = snakeApp.canvas.width / snakeApp.cellWidth;
snakeApp.gameHeight = snakeApp.canvas.height / snakeApp.cellWidth;
snakeApp.reset();
}

$(document).keydown(function(e){
  var key = e.which;
  if(key == "37" && snakeApp.curr_direction != "right" && snakeApp.state == 'playing') {
    snakeApp.direction = "left";
  } else if(key == "38" && snakeApp.curr_direction != "down" && snakeApp.state == 'playing') { 
    snakeApp.direction = "up";
  } else if(key == "39" && snakeApp.curr_direction != "left" && snakeApp.state == 'playing') {
    snakeApp.direction = "right";
  } else if(key == "40" && snakeApp.curr_direction != "up" && snakeApp.state == 'playing') {
    snakeApp.direction = "down";
  } else if (key == "32" && snakeApp.state == 'welcome') {
    snakeApp.play();
  } else if (key == "32" && snakeApp.state == 'gameover') {
    snakeApp.reset();
  }
})

});