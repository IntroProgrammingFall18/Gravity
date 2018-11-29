void initializeTable() {
  saveData = new Table();
  saveData.addColumn("xLocation", Table.FLOAT);
  saveData.addColumn("yLocation", Table.FLOAT);
  saveData.addColumn("xVelocity", Table.FLOAT);
  saveData.addColumn("yVelocity", Table.FLOAT);
}

void load(){
  loadData = loadTable("saveData.csv", "header");
  println(loadData.getRowCount());
  
  //remove the bodies that are left
  
  //repopulate the bodies
  
  //overwrite with info with data from loadData
  //body[0].lx = 
}
