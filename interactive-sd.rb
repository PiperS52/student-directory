@students = [] #an empty array accessible to all methods

def input_students
  puts "Please enter the names and cohort of the students"
  puts "To finish, just hit return twice"
  #students = []
  
  puts "Name?"
  name = gets.chomp
  puts "Cohort?"
  cohort = gets.chomp
  while !name.empty? do
    if cohort.empty?
      cohort = "Jan"
    else
      @students << {name: name, cohort: cohort}
      if @students.size > 1
        puts "Now we have #{@students.count} students"
      else
        puts "Now we have 1 student"
      end 
      puts "Another name?"
      name = gets.chomp
      if name.empty?
        break
      else
        puts "Cohort?"
        cohort = gets.chomp
      end 
    end 
  end 
  @students 
end 

def print_header
  puts ("The students of Villains Academy")
  puts ("-------------")
end 

def print_student_list # method 1 (.each.with_index)
  @students.each.with_index do |student, idx|
    if student[:name].length < 12
      puts "#{idx+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end 
  end 
end 

def print_by_cohort # print selected cohort - could be added as option to print_menu and show_students
  puts "Which cohort to display?"
  co_todisp = gets.chomp
  @students.select! do |student|
    if student[:cohort] == co_todisp
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end 
end 
    
def print_footer
  puts "Overall, we have #{@students.count} great students".center(10)
end 

#students = input_students
# calling the methods
# print_header
# print(students)
# print_footer(students)

#print_by_cohort(students)

def print_menu
  # 1. Print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end 

def show_students
  print_header 
  print_student_list
  print_footer
end 

def process(selection)
  case selection
  when "1"
    input_students 
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students 
  when "9"
    exit 
  else
    puts "I don't know what you mean, try again"
  end 
end 

def save_students
  # open the file for writing
  file = File.open("students.csv","w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line 
  end 
  file.close 
end 

def load_students 
  file = File.open("students.csv", "r")
  file.readlines.each do |line| 
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort}
  end 
  file.close 
end 

## interactive menu
def interactive_menu
  #students = [] no longer needed
  loop do 
    # 1. Print the menu and ask the user what to do
    print_menu 
    # 2. Read the input and save it to a variable
    # 3. Do what the user has asked 
    process(gets.chomp)
  end 
end 
    
interactive_menu 