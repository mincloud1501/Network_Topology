from tkinter import *
from tkinter import ttk


class Calculator:
    operation = ''
    temp_number = 0
    answer_trigger = False

    def key_input(self, value):
        # 쉬프트키 입력 무시.(덧셈할때)
        if not repr(value.char) == "''":
            numbers = '1234567890'
            operators = '/*+-'
            # 숫자키 입력시, button_pressed()함수 호출.
            if value.char in numbers:
                self.button_pressed(value.char)
                print(value.char)
            # 연산자 입력시, math_button_pressed() 함수 호출.
            elif value.char in operators:
                self.math_button_pressed(value.char)
                print(value.char)
            # 엔터키 입력 -> =버튼
            elif value.keysym == "Return":
                self.equal_button_pressed()
                print("equal button pressed")
            # ESC 키 입력. -> AC 버튼 입력.
            elif value.keysym == "Escape":
                self.button_pressed('AC')
                print('AC button pressed')
            # BackSpace 입력시, 마지막 한글자 삭제.
            elif value.keysym == "BackSpace":
                self.number_entry.delete(len(self.number_entry.get()) - 1, 'end')
                print(self.number_entry)

    def button_pressed(self, value):
        if value == 'AC':
            self.number_entry.delete(0, 'end')
            self.operation = ''
            self.answer_trigger = False
            print("AC pressed")
        else:
            if self.answer_trigger:
                self.number_entry.delete(0, "end")
                self.answer_trigger = False
            self.number_entry.insert("end", value)
            print(value, "pressed")

    def float_filter(self, value):
        try:
            int(value)
            return int(value)
        except ValueError:
            return float(value)

    def int_changer(self, value):
        if int(value) == float(value):
            return int(value)
        else:
            return float(value)

    def math_button_pressed(self, value):
        if not self.number_entry.get() == '':
            self.operation = value
            self.temp_number = self.float_filter(self.number_entry.get())
            self.number_entry.delete(0, 'end')
            print(self.temp_number, self.operation)

    def equal_button_pressed(self):
        if not (self.operation == '' and self.number_entry.get() == ''):
            number = int(self.number_entry.get())
            if self.operation == '/':
                solution = self.temp_number / number
            elif self.operation == '*':
                solution = self.temp_number * number
            elif self.operation == '+':
                solution = self.temp_number + number
            else:
                solution = self.temp_number - number

            solution = self.int_changer(solution)
            self.number_entry.delete(0, 'end')
            self.number_entry.insert(0, solution)
            print(self.temp_number, self.operation, number, "=", solution)
            self.operation = ''
            self.temp_number = 0
            self.answer_trigger = True

    def __init__(self, root):
        root.title("Calculator")
        root.geometry("300x200")
        # 키보드 입력값을 self.key_input() 함수로 넘겨줌.
        root.bind('<Key>', self.key_input)

        self.entry_value = StringVar(root, value='')

        self.number_entry = ttk.Entry(root, textvariable=self.entry_value, width=20)
        self.number_entry.grid(row=0, columnspan=3)

        self.button7 = ttk.Button(root, text="7", command=lambda: self.button_pressed('7'))
        self.button7.grid(row=1, column=0)
        self.button8 = ttk.Button(root, text="8", command=lambda: self.button_pressed('8'))
        self.button8.grid(row=1, column=1)
        self.button9 = ttk.Button(root, text="9", command=lambda: self.button_pressed('9'))
        self.button9.grid(row=1, column=2)

        self.button_div = ttk.Button(root, text="/", command=lambda: self.math_button_pressed('/'))
        self.button_div.grid(row=1, column=3)

        self.button4 = ttk.Button(root, text="4", command=lambda: self.button_pressed('4'))
        self.button4.grid(row=2, column=0)
        self.button5 = ttk.Button(root, text="5", command=lambda: self.button_pressed('5'))
        self.button5.grid(row=2, column=1)
        self.button6 = ttk.Button(root, text="6", command=lambda: self.button_pressed('6'))
        self.button6.grid(row=2, column=2)

        self.button_mult = ttk.Button(root, text="*", command=lambda: self.math_button_pressed('*'))
        self.button_mult.grid(row=2, column=3)

        self.button1 = ttk.Button(root, text="1", command=lambda: self.button_pressed('1'))
        self.button1.grid(row=3, column=0)
        self.button2 = ttk.Button(root, text="2", command=lambda: self.button_pressed('2'))
        self.button2.grid(row=3, column=1)
        self.button3 = ttk.Button(root, text="3", command=lambda: self.button_pressed('3'))
        self.button3.grid(row=3, column=2)

        self.button_add = ttk.Button(root, text="+", command=lambda: self.math_button_pressed('+'))
        self.button_add.grid(row=3, column=3)

        self.button_ac = ttk.Button(root, text="AC", command=lambda: self.button_pressed('AC'))
        self.button_ac.grid(row=4, column=0)
        self.button0 = ttk.Button(root, text="0", command=lambda: self.button_pressed('0'))
        self.button0.grid(row=4, column=1)
        self.button_equal = ttk.Button(root, text="=", command=lambda: self.equal_button_pressed())
        self.button_equal.grid(row=4, column=2)
        self.button_sub = ttk.Button(root, text="-", command=lambda: self.math_button_pressed('-'))
        self.button_sub.grid(row=4, column=3)

root = Tk()
calc = Calculator(root)
root.mainloop()