# jQuery(function() {
#     // var areas;
#     // // $('#attraction_area_id').parent().hide();
#     // areas = $('#attraction_area_id').html();
#     // // console.log(areas);
#     // return $('#attraction_location_id').change(function() {
#     //     var location, escaped_location, blank, options;
#     //     location = $('#attraction_location_id :selected').text();
#     //     escaped_location = location.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
#     //     blank = "<option value>None</option>"
#     //     options = $(areas).filter("optgroup[label=" + escaped_location + "]").html();
#     //     // console.log(options);
#     //     if (options) {
#     //         $('#attraction_area_id').html(blank + options);
#     //     return $('#attraction_area_id').parent().show();
#     //     } else {
#     //         $('#attraction_area_id').empty();
#     //         return $('#attraction_area_id').parent().hide();
#     //     }
#     // });
# });

jQuery ->
    refreshAreas = ->
        if $('#attractions').length && ($('#attractions').attr("data-action") == "edit" || $('#attractions').attr("data-action") == "new") # If we're in attractions edit/new page
            console.log("refreshing areas")
            locationIndex = $('#attraction_location_id :selected').index()
            if locationIndex == 0
                $('#attraction_area_id').parent().hide()

            areas = $('#allareasoptions').html()
            location = $('#attraction_location_id :selected').text()
            escaped_location = location.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
            blank = "<option value>None</option>"
            options = $(areas).filter("optgroup[label=#{escaped_location}]").html()
            if options
                $('#attraction_area_id').html(blank + options)
                $('#attraction_area_id').parent().show()      
            else
                $('#attraction_area_id').html(blank)
                $('#attraction_area_id').parent().show()
        
    refreshAreas()

    $('#attraction_location_id').change -> 
        refreshAreas()

    $(document).on "turbolinks:load", ->
        refreshAreas()


    