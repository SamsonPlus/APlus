
window.onload = function(){
  var url = 'https://raw.githubusercontent.com/progers/pathseg/master/pathseg.js';
  loadGitHubScript(url).then(function () {

    // module aliases
    var Engine = Matter.Engine,
    Events = Matter.Events,
    Render = Matter.Render,
    World = Matter.World,
    Runner = Matter.Runner,
    Bodies = Matter.Bodies,
    Body = Matter.Body,
    Composites = Matter.Composites,
    Composite = Matter.Composite,
    Common = Matter.Common,
    Svg = Matter.Svg,
    Vertices = Matter.Vertices;

    // create an engine
    var engine = Engine.create();

    // create a renderer for the whole scene
    var render = Render.create({
      element: document.body,
      engine: engine,
      options:{
        width:window.innerWidth,
        wireframes:false,
        background: "white"
      }
    });
    //maintain aspect ratio
    Render.setPixelRatio(render, "auto");

    // set lighter gravity
    engine.world.gravity.y = .08;
    engine.world.gravity.scale = .001;

    var ymmBall = Composite.create();

    var ground = Bodies.rectangle(window.innerWidth/2, 610, window.innerWidth, 60, { isStatic: true });
    World.add(engine.world, ground);

    var vertexSets = [];
    $('#letters').load('images/letters.svg',function(){
      $(this).find('path').each(function(i, path){
        var letter = 'M';
        if(i===2){
          var letter = 'Y';
        }

        var v = Bodies.fromVertices(100+(i*80), 80, Svg.pathToVertices(path, 20), {
          render: {
            fillStyle: '#4C3BE7',
            strokeStyle: '#4C3BE7',
            lineWidth: 1
          },
          friction:.9,
          frictionAir: 0.05,
          frictionStatic: 0.1,
          restitution:1,
          label:letter
        }, true);
        vertexSets.push(v);
        console.log(v);
      });
      //add to world
      World.add(engine.world, vertexSets);
      vertexSets.forEach((item, i) => {
        console.log(i);
        Body.setPosition(item, { x: 300, y: 300 });
        Body.scale(item, 2, 2);
        Composite.add(ymmBall, vertexSets);
      });
    });


    var wheel;
      $('#wheel').load('images/wheel.svg',function(){
        $(this).find('path').each(function(i, path){
          World.add(engine.world, Bodies.fromVertices(100+(i*80), 80, Svg.pathToVertices(path, 20), {
            render: {
              fillStyle: '#4C3BE7',
              strokeStyle: '#4C3BE7',
              lineWidth: 1
            },
            friction:.9,
            id:69,
            label:"wheel",
            frictionAir: 0.05,
            frictionStatic: 0.1,
            restitution:1
          }, true)
        );
        });
        console.log(Composite.allBodies(engine.world));
        wheel = Composite.get(engine.world, 69, "body");
        Body.scale(wheel, .5, .5);
        Body.setPosition(wheel, { x: 300, y: 300 });
        //Composite.add(ymmBall, wheel);
      });



  //this moves a composite
  //  Matter.Composite.translate(ymmBall, {x: 100,y: 100});
    World.add(engine.world, ymmBall);
    //--------------------------------------
    // run the engine
    Engine.run(engine);

    // run the renderer
    Render.run(render);


    var counter = 0;
    //event loop

    Events.on(engine, 'beforeUpdate', function(event) {

      counter += 1;

      //Body.setPosition(wheel, { x: , y: 50 });
      //Body.rotate(wheel, 0.02);
      //Body.rotate(wheel, Math.cos(counter/50) * 0.03);
      Body.rotate(wheel, .02);
      Composite.rotate(ymmBall, .03, {x: 400,y: 400});
      Body.setStatic(wheel, true);
    });



  });
};
