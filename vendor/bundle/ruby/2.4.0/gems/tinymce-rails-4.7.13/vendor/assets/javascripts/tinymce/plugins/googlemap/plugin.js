var map_info="";
(function() {
  tinymce.PluginManager.requireLangPack('googlemap');
  tinymce.create('tinymce.plugins.GoogleMap', {
    GoogleMap: function(ed, url) {
      var form,
          iframe,
          win,
          throbber,
          editor = ed;
      function showDialog() {
        win = editor.windowManager.open({
          file : url + '/googleMap.html',
          width : 650 + ed.getLang('googlemap.delta_width', 0),
          height : 500 + ed.getLang('googlemap.delta_height', 0),
          inline : 1,
          title: ed.translate('Insert an image from your computer'),
          buttons: [
            {
              text: ed.translate('Insert'),
              onclick: insertImage,
              subtype: 'primary'
            },
            {
              text: ed.translate('Cancel'),
              onclick: ed.windowManager.close
            }
          ],
        }, {
          plugin_url: url
        });
      }
      function insertImage() {
        ed.execCommand('mceInsertContent', false, buildHTML(map_info));
        ed.windowManager.close();
      }

      function clearErrors() {
        var message = win.find(".error")[0].getEl();

        if(message)
          message.getElementsByTagName("p")[0].innerHTML = "&nbsp;";
      }

      function handleError(error) {
        var message = win.find(".error")[0].getEl();

        if(message)
          message.getElementsByTagName("p")[0].innerHTML = ed.translate(error);
      }

      function createElement(element, attributes) {
        var el = document.createElement(element);
        for(var property in attributes) {
          if (!(attributes[property] instanceof Function)) {
            el[property] = attributes[property];
          }
        }

        return el;
      }

      function buildHTML(map_info) {
        var imgstr = "<iframe src='" + "//www.google.com/maps/embed/v1/place?key=AIzaSyCzH61sb85x96ENXJ79aEiDTOlkYiFtb8Y&q="+ map_info;
        
        imgstr += "'width='"+650+"' height='"+500+"' frameborder='0' style='border:0' allowfullscreen/>";

        return imgstr;
      }

      function getInputValue(name) {
        var inputs = form.getElementsByTagName("input");

        for(var i in inputs)
          if(inputs[i].name == name)
            return inputs[i].value;

        return "";
      }

      function getMetaContents(mn) {
        var m = document.getElementsByTagName('meta');

        for(var i in m)
          if(m[i].name == mn)
            return m[i].content;

        return null;
      }

      // Add a button that opens a window
      editor.addButton('googlemap', {
        tooltip: ed.translate('Insert an image from your computer'),
        icon : 'image',
        onclick: showDialog
      });

      // Adds a menu item to the tools menu
      editor.addMenuItem('googlemap', {
        text: ed.translate('Insert an image from your computer'),
        icon : 'image',
        context: 'insert',
        onclick: showDialog
      });
    }
  });

  tinymce.PluginManager.add('googlemap', tinymce.plugins.GoogleMap);
})();
