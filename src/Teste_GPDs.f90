! Este módulo define uma interface para várias sub-rotinas 
! relacionadas ao cálculo de funções de distribuição da biblioteca LHAPDF
module Teste_GPDs
    
    implicit none ! Impede a declaração implícita de variáveis
    
    ! Definição da interface das sub-rotinas
    interface
      
      Subroutine GetMinMax(i, xmin, xmax, q2min, q2max)
      ! Sub-rotina para obter os valores mínimo e máximo das variáveis
          integer, intent(in):: i ! Índice de entrada
          double precision:: xmin, xmax, q2min, q2max ! Variáveis para armazenar valores mínimo e máximo
      End Subroutine GetMinMax
      
      ! Sub-rotina para obter o valor máximo
      Subroutine GetXmax(i, xmax)
          integer, intent(in):: i ! Índice de entrada
          double precision:: xmax ! Variável para armazenar o valor máximo
      End Subroutine GetXmax 
      
      ! Sub-rotina para obter o valor mínimo
      Subroutine GetXmin(i, xmin)
          integer, intent(in):: i ! Índice de entrada
          double precision:: xmin ! Variável para armazenar o valor mínimo
      End Subroutine GetXmin
      
      ! Sub-rotina para calcular a evolução da PDF
      Subroutine evolvePDF(x, Q, f)
          double precision:: x, Q, f(-6:6) ! Entradas e saída
      End Subroutine evolvePDF
      
      ! Sub-rotina para inicializar um conjunto de PDFs pelo nome
      Subroutine InitPDFsetByName(name)
           character(64):: name ! Nome do conjunto de PDFs
      End Subroutine InitPDFsetByName
      
      ! Sub-rotina para inicializar um conjunto de PDFs pelo índice
      Subroutine InitPDF(i)
          integer, intent(in):: i ! Índice do conjunto de PDFs
      End Subroutine InitPDF

      function alphasPDF(Q2)
          real(8) :: Q2, alphasPDF
      end function  
    end interface
  
  end module Teste_GPDs
  