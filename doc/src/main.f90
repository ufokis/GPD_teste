program main
    use Teste_GPDs ! Importa o módulo Teste_GPDs que contém as sub-rotinas necessárias
   
    implicit none ! Impede a declaração implícita de variáveis
    
    ! Declaração das variáveis
    character(64):: name ! Nome do conjunto de dados
    double precision f(-6:6), xmin, xmax, q2min, q2max, x, Q, alphasPDF, I1, I2 ! Variáveis numéricas
    double precision:: step ! Tamanho do passo
    integer:: num_steps ! Número de passos
    character(20):: arg ! Argumento da linha de comando
    integer:: i, ix ! Índices
  
    ! Inicializando os argumentos
    Q = 0.0d0
    name = ''

    ! Analisando os argumentos da linha de comando
    do i = 1, command_argument_count()
        call get_command_argument(i, arg)
        select case (arg)
            case ("-Q")
                call get_command_argument(i+1, arg)
                read(arg, *) Q
            case ("-name")
                call get_command_argument(i+1, name)
        end select
    end do

    ! Verificando se os argumentos necessários foram fornecidos
    if (Q == 0.0d0 .or. name == '') then
        print *, "Erro: Por favor, forneça o valor de Q e o nome do conjunto de dados."
        stop
    end if

    ! Inicialização do conjunto de dados pelo nome fornecido
    call InitPDFsetByName(name)

    ! Inicialização de um conjunto de PDFs
    call InitPDF(0)
    ! Obtendo os valores mínimos e máximos de x e Q2
    call GetXmin(0, xmin)
    call GetXmax(0, xmax)
    
    ! Exibindo os valores mínimos e máximos de x e Q2
    print *,'xmin=',xmin, ' xmax=',xmax, ' Q2min=',q2min, ' Q2max=',q2max

    ! Adaptação para x variar de xmin a xmax com passo constante
    
    step = 0.0001d0  ! Defina aqui o tamanho do passo desejado
    num_steps = nint((xmax-1.d-7) / step)

    ! Abertura dos arquivos de saída
    open(unit = 2, file='pdf1_' // trim(name) // '.dat', status='unknown')
    open(unit = 3, file='pdf2_' // trim(name) // '.dat', status='unknown')
   
    ! Loop para calcular e escrever os resultados
    do ix = 0, num_steps
        x = 1.d-7 + real(ix) * step

        ! Calcula a evolução da PDF para o valor atual de x e Q
        call evolvePDF(x, Q, f)

        ! Calcula as integrais I1 e I2
        I1 = f(0)
        I2 = (sum(f(1:4)) + sum(f(-1:-4)))/x
        
        ! Escreve os resultados nos arquivos de saída
        write(2, *) x, I1
        write(3, *) x, I2*1.d-2
    end do

end program main
