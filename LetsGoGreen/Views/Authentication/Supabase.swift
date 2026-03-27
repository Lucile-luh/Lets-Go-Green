//
//  Supabase.swift
//  LetsGoGreen
//
//  Created by Lucile G on 20/3/2026.
//

import Foundation
import Supabase

// Reusable Supabase client for authentication requests.
let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://norphdjufkrquwmstezh.supabase.co")!,
    supabaseKey: "sb_publishable_7p6hfJgMl4hkp4X0QBy64A_PiMVb5CT",
    options: SupabaseClientOptions(
        auth: .init(emitLocalSessionAsInitialSession: true)
    )
)
