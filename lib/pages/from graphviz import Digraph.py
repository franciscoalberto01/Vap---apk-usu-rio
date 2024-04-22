from graphviz import Digraph

# Inicializando um objeto Digraph para o fluxograma
dot = Digraph(comment='Sistema de Streaming de Vídeo com Balanceamento de Carga')

# Adicionando os nós (elementos) ao fluxograma
dot.node('A', 'Requisição do Usuário')
dot.node('B', 'Servidores Distribuídos')
dot.node('C', 'CDNs (Content Delivery Networks)')
dot.node('D', 'Balanceamento de Carga')
dot.node('E', 'Entrega de Conteúdo')
dot.node('F', 'Usuário Recebe o Vídeo')

# Adicionando as arestas (conexões) ao fluxograma
dot.edge('A', 'B', 'Direcionamento')
dot.edge('B', 'C', 'Seleção de CDN')
dot.edge('C', 'D', 'Gerenciamento de Carga')
dot.edge('D', 'E', 'Determinação do Melhor Caminho')
dot.edge('E', 'F', 'Transmissão do Vídeo')

# Renderizando o fluxograma para um arquivo de imagem
dot.render('streaming_video_system', format='png', view=True)
