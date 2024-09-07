import flet as ft
import requests
import sqlite3

def main(Page: ft.Page):
    Page.title = 'Register Page'
    Page.theme_mode = 'light'
    Page.vertical_alignment = ft.MainAxisAlignment.CENTER
    Page.window.width = 350
    Page.window.height = 400
    Page.window.resizable = False

    def register(e):
        db = sqlite3.connect('register_test')
        
        cur = db.cursor()
        cur.execute("""CREATE TABLE IF NOT EXISTS users (
                                                            id INTEGER PRIMARY KEY,
                                                            login TEXT,
                                                              pass TEXT
        )""")
        cur.execute(f"INSERT INTO users VALUES(NULL, '{user_login.value}', '{user_password.value}')")
        
        db.close()

        user_login.value = ''
        user_password.value = ''
        btn_reg.text = 'Complete ! '
        Page.update()
        pass

    def validate(e):
        if all([user_login.value, user_password.value]):
            btn_reg.disabled = False
        else:
            btn_reg.disabled = True

        Page.update()

    user_login = ft.TextField(label='Login', width=200, on_change=validate)
    user_password = ft.TextField(label='Password', width=200, on_change=validate)
    btn_reg = ft.OutlinedButton(text='Continue', width= 200, on_click=register)

    Page.add(
        ft.Row(
            [
                ft.Column(
                    [
                        ft.Text('Register'),
                        user_login,
                        user_password,
                        btn_reg
                    ]
                )
            ],
            alignment=ft.MainAxisAlignment.CENTER
        )
    )


ft.app(target=main, view=ft.AppView.WEB_BROWSER)
