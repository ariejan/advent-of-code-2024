class Day05
  def part_one(input)
    parse_input(input)

    @updates
      .select { |update| correct_order?(update) }
      .map { |result| result[result.size / 2] }
      .sum
  end

  def part_two(input)
    parse_input(input)

    @updates
      .reject { |update| correct_order?(update) }
      .map { |update| reorder(update) }
      .map { |result| result[result.size / 2] }
      .sum
  end

  def correct_order?(update)
    @order.all? do |p1, p2|
      (update.include?(p1) && update.include?(p2) && update.index(p1) < update.index(p2)) || (!update.include?(p1) || !update.include?(p2))
    end
  end

  def reorder(update)
    @relevant_order = @order
                      .select { |order| update.include?(order[0]) && update.include?(order[1]) }

    re = Reorder.new(@relevant_order)
    re.reorder_update(update)
  end

  def parse_input(input)
    lines = input.split("\n")
    split_idx = lines.index('')

    @order = lines[0..split_idx - 1].map { |line| line.split('|').map(&:to_i) }
    @updates = lines[split_idx + 1..-1].map { |line| line.split(',').map(&:to_i) }
  end
end

class Reorder
  def initialize(relevant_order)
    @relevant_order = relevant_order
  end

  def reorder_update(update)
    graph = build_graph(@relevant_order)
    sorted_order = topological_sort(graph)
    update.sort_by { |num| sorted_order.index(num) }
  end

  private

  def build_graph(relevant_order)
    graph = Hash.new { |hash, key| hash[key] = [] }
    relevant_order.each do |before, after|
      graph[before] << after
    end
    graph
  end

  def topological_sort(graph)
    visited = {}
    stack = []

    graph.keys.each do |node|
      topological_sort_util(node, visited, stack, graph) unless visited[node]
    end

    stack.reverse
  end

  def topological_sort_util(node, visited, stack, graph)
    visited[node] = true
    graph[node].each do |neighbor|
      topological_sort_util(neighbor, visited, stack, graph) unless visited[neighbor]
    end
    stack << node
  end
end
