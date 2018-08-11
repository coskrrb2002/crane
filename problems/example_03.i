[Mesh]
  type = GeneratedMesh
  dim = 1
  xmin = 0
  xmax = 1
  nx = 1
  elem_type = EDGE2
[]

[Variables]
  # ODE variables
  [./A]
  [../]

  [./B]
  [../]

  [./C]
  [../]
[]

[ICs]
  [./A_init]
    type = ConstantIC
    variable = A
    value = 100
  [../]

  [./B_init]
    type = ConstantIC
    variable = B
    value = 10
  [../]

  [./C_init]
    type = ConstantIC
    variable = C
    value = 0
  [../]
[]

[NodalKernels]
  [./dA_dt]
    type = TimeDerivativeNodalKernel
    variable = A
  [../]
  [./dB_dt]
    type = TimeDerivativeNodalKernel
    variable = B
  [../]
  [./dC_dt]
    type = TimeDerivativeNodalKernel
    variable = C
  [../]

  [./A_sink]
    type = ReactantARxn
    variable = A
    coefficient = -1.0
    rate_coefficient = 1.0
  [../]
  [./A_source]
    type = ProductARxn
    variable = A
    v = B
    coefficient = 1.0
    rate_coefficient = 1.0
  [../]

  [./B_sink]
    type = ReactantARxn
    variable = B
    coefficient = -1.0
    rate_coefficient = 1.0
  [../]
  [./B_source]
    type = ProductARxn
    variable = B
    v = A
    coefficient = 1.0
    rate_coefficient = 1.0
  [../]
  
  [./C_source]
    type = Product2Body
    variable = C
    v = A
    w = B
    coefficient = 1
    rate_coefficient = 0.001
  [../]
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 10
  trans_ss_check = true
  ss_check_tol = 1e-4
  [./TimeStepper]
    type = ConstantDT
    dt = 0.1
  [../]
  #Preconditioned JFNK (default)
  solve_type = 'JFNK'
[]

[Outputs]
  exodus = true
[]
