---
title: Data Extractor
---

## Introduction

Data Extractor extracts command and telemetry items into comma or tab separated files. Individual items or entire packets can be processed over any time period. Data Extractor also has a number of options to control the output for post processing in Excel or Matlab, for example.

![Data Extractor](/img/data_extractor/data_extractor.png)

## Data Extractor Menus

### File Menu Items

<!-- Image sized to match up with bullets -->

<img src="/img/data_extractor/file_menu.png"
alt="File Menu"
style={{"float": 'left', "margin-right": 50 + 'px', "height": 160 + 'px'}} />

- Opens a saved configuration
- Save the current configuration (item list)
- Delimit output with commas
- Delimit output with tabs

#### Open Configuration

The Open and Save Configuration options deserve a little more explanation. When you select File Open the Open Configuration dialog appears. It displays a list of all saved configurations (INST_TEMPS in this example). You select a configuration and then click Ok to load it. You can delete existing configurations by clicking the Trash icon next to a configuration name.

![Open Config](/img/data_extractor/open_config.png)

#### Save Configuration

When you select File Save the Save Configuration dialog appears. It displays a list of all saved configurations (INST_TEMPS in this example). You click the Configuration Name text field, enter the name of your new configuration, and click Ok to save. You can delete existing configurations by clicking the Trash icon next to a configuration name.

![Save Config](/img/data_extractor/save_config.png)

### Mode Menu Items

<!-- Image sized to match up with bullets -->

<img src="/img/data_extractor/mode_menu.png"
alt="Mode Menu"
style={{"float": 'left', "margin-right": 50 + 'px', "height": 250 + 'px'}} />

- Fill empty cells with the previous value
- Add a Matlab comment ('%') to the header
- Only output changed values
- Only list item name as column header
- List full Target Packet Item as header

## Selecting Items for Output

### Start/End Date/Time

Data Extractor provides text fields where you specify the time range to extract items. Clicking the Start Date and End Date text fields opens a Date Chooser dialog. Note you can also manually type in the date.

![Date Chooser](/img/data_extractor/date_chooser.png)

Clicking the Start Time and End Time icon opens up a Time Chooser dialog. Note you can also manually type in the time.

![Time Chooser](/img/data_extractor/time_chooser.png)

### Adding Targets Packets Items

Data Extractor provides Target, Packet, Item drop downs to select the items you want to export. When you select a Target the Packet drop down defaults to \[All\] which sets the button to "Add Target". This would add EVERY item defined in EVERY packet in the target. Note: This can be a LOT of telemetry points but any added point can be removed.

![Select Target](/img/data_extractor/select_target.png)

When you select a Packet the Item drop down defaults to \[All\] which sets the button to "Add Packet". This would add EVERY item defined in the specified packet. Note: This can be a LOT of telemetry points but any added point can be removed.

![Select Packet](/img/data_extractor/select_packet.png)

When you select an individual Item the button changes to "Add Item" and the Description field updates with the item's description.

![Select Item](/img/data_extractor/select_item.png)

### Removing Items

Once you've added items the Items table will have a list of items.

![Items Table](/img/data_extractor/items_table.png)

Items can be removed by clicking the Trash icon next to the item. ALL items can be removed by clicking the Trash icon in the header.

![Delete All Mouseover](/img/data_extractor/delete_all_mouseover.png)

### Editing Items

Items can be edited by clicking the Pencil icon next to the item. ALL items can be edited by clicking the pencil icon in the header.

![Edit All Mouseover](/img/data_extractor/edit_all_mouseover.png)

Clicking the Edit All brings up the Edit All Items dialog.

![Edit All](/img/data_extractor/edit_all_items.png)

This allows you to change the data type of all items in the list. In this example we change from the default of CONVERTED to RAW. This updates the item list as follows.

![Items Table Raw](/img/data_extractor/items_table_raw.png)

Clicking the pencil next to an individual item brings up a similar dialog.

![Edit TEMP1](/img/data_extractor/edit_temp1.png)

If we change TEMP1 back to CONVERTED the item list is again updated.

![Edit TEMP1](/img/data_extractor/items_table_temp1.png)

## Processing Items

Clicking the Process button starts the processing of the items list. A progress wheel is shown on the left side of the table and the Process button changes to Cancel to allow cancelling the process.

![Processing](/img/data_extractor/processing.png)

When the processing is complete, the browser shows a file download link. Note this varies by browser. This example is from Chrome.

![Download](/img/data_extractor/download.png)
