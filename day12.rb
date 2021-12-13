def day12(string)
  paths = string.split("\n").map { |line| line.split("-") }
  nodes_hash = paths.flatten.uniq.map { |path_name| [path_name, Node.new(path_name)] }.to_h
  nodes_hash.values.each do |node|
    node.connect(paths)
  end
  paths = []
  find_paths(nodes_hash, [nodes_hash["start"]], paths)
  paths.each do |path|
    puts path.map(&:name).join("-")
  end
  paths.size
end

def find_paths(nodes_hash, current_path, paths)
  # puts current_path.map(&:name).inspect
  connected_nodes = current_path.last.connections.map { |node_name| nodes_hash[node_name] }
  connected_nodes.each do |node|
    if node.can_go?(current_path)
      if node.name == "end"
        paths << (current_path + [node])
      else
        find_paths(nodes_hash, (current_path + [node]), paths)
      end
    end
  end
end

class Node
  def initialize(name)
    @name = name
    @is_large = name[0].capitalize == name[0]
    @connections = []
  end

  def name
    @name
  end

  def is_large?
    @is_large
  end

  def connections
    @connections
  end

  def connect(paths)
    paths.each do |path|
      if @name == path[0]
        @connections << path[1]
      elsif @name == path[1]
        @connections << path[0]
      end
    end
  end

  def can_go?(previous_path)
    return false if name == "start"
    can_revisit_small_cave = previous_path.reject(&:is_large?).group_by(&:name).all? { |k, v| v.size == 1 }
    previous_visits = previous_path.map(&:name).count(@name)
    @is_large || can_revisit_small_cave  ? true : previous_visits < 1
  end
end