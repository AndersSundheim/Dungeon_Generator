Delaunay = require 'Delaunay'

function gen()
  x1 = math.random(0,love.graphics.getWidth()-110)
  y1 = math.random(0,love.graphics.getHeight()-110)
  w1 = math.random(10,100)
  h1 = math.random(10,100)
  fail = false
  for i=1,#r do
    if r[i].x==nil or (testIntersectx(x1,r[i].x,w1,r[i].w) and testIntersecty(y1,r[i].y,h1,r[i].h)) then
      print('fail')
      fail = true
    end
  end
  if fail == true then
    return nil
  end
  return {xx = x1, yy = y1, ww = w1, hh = h1}
end
function testIntersectx(x1,x2,w1,w2)
  if (x1>=x2 and x1<=(x2+w2)) or (x1+w1>=x2 and x1+w1<=(x2+w2))or (x1<=x2 and x1+w1>=x2+w2) then
    return true
  end
  return false
end
function testIntersecty(y1,y2,h1,h2)
  if (y1>=y2 and y1<=(y2+h2)) or (y1+h1>=y2 and y1+h1<=(y2+h2))or (y1<=y2 and y1+h1>=y2+h2) then
    return true
  end
  return false
end
function doesexist(tab, val)
  for i=1,#tab do
    if val == tab[i] then
      return true
    end
  end
  return false
end
function edgeSame(a,b)
  for i=1,#b do
    if a:same(b[i]) then
      return true
    end
  end
  return false
end

function love.load( arg )
	l={}
  r = {}
  start = false
  points = {}
  edges = {}
  math.randomseed(os.clock()*100000000000)
  for i=1,50 do  
    t = gen()
    if t~=nil then
      table.insert(r,{x=t.xx,y=t.yy,w=t.ww,h=t.hh})
    end  
  end
  for j = 1,#r do
    points[j] = Delaunay.Point(r[j].x+(r[j].w/2),r[j].y+(r[j].h/2))
  end
  
  triangles = Delaunay.triangulate(unpack(points))
  for i, triangle in ipairs(triangles) do
    table.insert(edges,Delaunay.Edge(triangle.p1,triangle.p2))
    table.insert(edges,Delaunay.Edge(triangle.p2,triangle.p3))
    table.insert(edges,Delaunay.Edge(triangle.p3,triangle.p1))
  end
  tree = {}
  addtree = {}
  for i = 1, .05*#edges do
    table.insert(addtree,edges[math.random(1,#edges)])
  end
  
  
  vertices = {points[1]}
  while #vertices ~= #points do
    ln = 10000
    temp1 = nil
    temp2 = nil
    for i = 1, #vertices do
      for p = 1, #points do
        if doesexist(vertices,points[p])==false then
            if points[p]:dist(vertices[i])<ln and edgeSame(Delaunay.Edge(points[p],vertices[i]),edges) then
              ln = points[p]:dist(vertices[i])
              temp1 = points[p]
              temp2 = vertices[i]
            end
          end
        end
      end
      table.insert(vertices,temp1)
      table.insert(tree,Delaunay.Edge(temp1,temp2))
    end
    for i = 1, .01*#edges do
      f = math.random(1,#edges)
      if edgeSame(edges[f],tree) == false then
        table.insert(addtree,edges[f])
      end
    end
  temp = r
  local function tableSort(a,b)
    
  return a.x < b.x
  
end

table.sort( r, tableSort)

  for i=1,#r-1 do
    print(r[i].x)
      rs = math.random(2)
      if rs==2 then
        --table.insert(l,{x1=r[i].x+r[i].w,y1=r[i].y+(r[i].h/2),x2=r[i+1].x,y2=r[i+1].y+(r[i+1].w/2)})
        table.insert(l,{x1=r[i].x+r[i].w,y1=r[i].y+(r[i].h/2),x2=(r[i].x+r[i].w)+(0.5*(r[i+1].x-(r[i].x+r[i].w))),y2=r[i].y+(r[i].h/2)})
        table.insert(l,{x1=(r[i].x+r[i].w)+(0.5*(r[i+1].x-(r[i].x+r[i].w))),y1=r[i].y+(r[i].h/2),x2=(r[i].x+r[i].w)+(0.5*(r[i+1].x-(r[i].x+r[i].w))),y2=r[i+1].y+(r[i+1].h/2)})
        table.insert(l,{x1=(r[i].x+r[i].w)+(0.5*(r[i+1].x-(r[i].x+r[i].w))),y1=r[i+1].y+(r[i+1].h/2),x2=r[i+1].x,y2=r[i+1].y+(r[i+1].h/2)})
      end
      if rs==1 then
        if r[i].y+((r[i].y+r[i].h)/2)<r[i+1].y then
        table.insert(l,{x1=r[i].x+r[i].w,y1=r[i].y+(r[i].h/2),x2=(r[i].x+r[i].w)+((r[i+1].x-(r[i].x+r[i].w)))+(((r[i+1].x+r[i+1].w)-r[i+1].x)/2),y2=r[i].y+(r[i].h/2)})
        table.insert(l,{x1=(r[i].x+r[i].w)+((r[i+1].x-(r[i].x+r[i].w)))+(((r[i+1].x+r[i+1].w)-r[i+1].x)/2),y1=r[i].y+(r[i].h/2),x2=r[i+1].x+(((r[i+1].x+r[i+1].w)-r[i+1].x)/2),y2=r[i+1].y})
      end
      if r[i].y+((r[i].y+r[i].h)/2)>r[i+1].y then
          --table.insert(l,{x1=r[i].x+(0.5*((r[i].x+r[i].w)-r[i].x)),y1=r[i].y+r[i].h,x2=r[i].x+(0.5*((r[i].x+r[i].w)-r[i].x)),y2=r[i+1].y+(r[i+1].h/2)})
          table.insert(l,{x1=r[i].x+r[i].w,y1=r[i].y+(r[i].h/2),x2=(r[i].x+r[i].w)+(0.5*(r[i+1].x-(r[i].x+r[i].w))),y2=r[i].y+(r[i].h/2)})
        table.insert(l,{x1=(r[i].x+r[i].w)+(0.5*(r[i+1].x-(r[i].x+r[i].w))),y1=r[i].y+(r[i].h/2),x2=(r[i].x+r[i].w)+(0.5*(r[i+1].x-(r[i].x+r[i].w))),y2=r[i+1].y+(r[i+1].h/2)})
        table.insert(l,{x1=(r[i].x+r[i].w)+(0.5*(r[i+1].x-(r[i].x+r[i].w))),y1=r[i+1].y+(r[i+1].h/2),x2=r[i+1].x,y2=r[i+1].y+(r[i+1].h/2)})
      end
    end
  end
  
  start = true
end

function love.draw()
  
  if start == true then
    
    
    for i=1,#l do
      love.graphics.setColor(255,255,255,255)
      --love.graphics.line(l[i].x1,l[i].y1,l[i].x2,l[i].y2)
    end
    for i=1,#tree do
      love.graphics.line(tree[i].p2.x,tree[i].p1.y,tree[i].p2.x,tree[i].p2.y)
      love.graphics.line(tree[i].p1.x,tree[i].p1.y,tree[i].p2.x,tree[i].p1.y)
      --love.graphics.rectangle("line",tree[i].p1.x,tree[i].p1.y,tree[i].p2.x-tree[i].p1.x,tree[i].p2.y-tree[i].p1.y)
    end
    for i=1,#addtree do
      --love.graphics.line(addtree[i].p2.x,addtree[i].p1.y,addtree[i].p2.x,addtree[i].p2.y)
      --love.graphics.line(addtree[i].p1.x,addtree[i].p1.y,addtree[i].p2.x,addtree[i].p1.y)
      --love.graphics.rectangle("line",tree[i].p1.x,tree[i].p1.y,tree[i].p2.x-tree[i].p1.x,tree[i].p2.y-tree[i].p1.y)
    end
    for j=1,#r do
      if r[j].x~=nil then
        if r[j].w*r[j].h > 4500 then
        love.graphics.setColor(200,200,200,255)
      elseif r[j].w*r[j].h > 2000 then
        love.graphics.setColor(150,150,150,255)
      else
        love.graphics.setColor(100,100,100,255)
      end
        love.graphics.rectangle('fill',r[j].x,r[j].y,r[j].w,r[j].h)
    end
    
    
    for i, triangle in ipairs(triangles) do
      love.graphics.setColor(20,255,0,100)
      --love.graphics.polygon("line",triangle.p1.x,triangle.p1.y,triangle.p2.x,triangle.p2.y,triangle.p3.x,triangle.p3.y)
    end
    
    
    for i=1,#tree do
      love.graphics.setColor(255,0,0,100)
      --love.graphics.line(tree[i].p1.x,tree[i].p1.y,tree[i].p2.x,tree[i].p2.y)
    end
    
    
    
    for i=1,#addtree do
      --love.graphics.setColor(0,255,0,100)
      --love.graphics.line(addtree[i].p1.x,addtree[i].p1.y,addtree[i].p2.x,addtree[i].p2.y)
    end
  end
  end
end
