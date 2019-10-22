var eb = new vertx.EventBus(window.location.protocol + '//' +
                            window.location.hostname + ':' +
                            window.location.port + '/eventbus');

eb.onopen = function() {

  var renderListItem = function(mindMap) {

    var li = $('<li>');

    var openMindMap = function() {
      new MindMapEditor(mindMap, eb);    //해당 마인드맵이 클릭되면  MindMapEditor 객체를 만든다. 
      return false;                                      
    };                                                        

    var deleteMindMap = function() {

      eb.send('mindMaps.delete', {id: mindMap._id}, function() {
        li.remove();

      });
      return false;
    };

    // 네임클릭하면 마인드맵 활성화됨
    $('<a>').text(mindMap.name).attr('href', '#').on('click', openMindMap).appendTo(li); 
    $('<button>').text('Delete').on('click', deleteMindMap).appendTo(li);

    li.appendTo('.mind-maps');
  };

  $('.create-form').submit(function() {
    var nameInput = $('[name=name]', this);

    eb.send('mindMaps.save', {name: nameInput.val()}, function(result) {
      renderListItem(result);
      nameInput.val('');
    });
    return false;

  });



  eb.send('mindMaps.list', {}, function(res) {  // 서버와 접속되면 마인드맵 리스트를 얻어옵니다. 

    $.each(res.mindMaps, function() {
      renderListItem(this);  // 각 마인드맵을 인자로 넣어주고 리스트 갱신 
    })
  })

};